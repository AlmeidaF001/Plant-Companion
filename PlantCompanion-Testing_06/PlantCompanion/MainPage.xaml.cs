using Microsoft.Maui.Controls;
using Microsoft.Maui.Media;
using System;
using System.IO;
using System.Net.Http;
using System.Text.Json;
using System.Threading.Tasks;
using System.Linq;
using System.Collections.Generic;
using System.Text.Json.Serialization;
using Microsoft.Maui.ApplicationModel;
using Microsoft.Maui.Devices.Sensors;
using Firebase.Auth;
using Firebase.Database;
using Firebase.Database.Query;
using System.Text;

namespace PlantCompanion
{
    public partial class MainPage : ContentPage
    {
        private readonly string plantIdApiKey = "UXUnq8Jze9sG9VdzQVauJdDe9XSoCbQ2eAHP1fVBEf5nxGCYYD";
        private readonly string plantIdIdentifyUrl = "https://api.plant.id/v2/identify";
        private readonly string plantIdHealthUrl = "https://api.plant.id/v2/health_assessment";
        private FirebaseClient _firebaseClient;
        private IFirebaseAuthClient _authClient;

        private bool _isMenuOpen = false;
        private uint _animationLength = 250;

        public MainPage()
        {
            InitializeComponent();
            CheckAndRequestLocationPermission();
        }

        public void Initialize(IFirebaseAuthClient authClient, FirebaseClient firebaseClient)
        {
            _authClient = authClient;
            _firebaseClient = firebaseClient;
            
            // Atualiza as informações do usuário após a inicialização
            UpdateUserInfo();
        }

        private void UpdateUserInfo()
        {
            if (_authClient != null && _authClient.User != null)
            {
                // Atualiza o email do usuário no menu lateral
                UserEmailLabel.Text = _authClient.User.Info.Email;
                
                // Se quiser também atualizar o nome de exibição (se disponível)
                // UserNameLabel.Text = !string.IsNullOrEmpty(_authClient.User.Info.DisplayName) ? 
                //                      _authClient.User.Info.DisplayName : "Usuário";
            }
            else
            {
                UserEmailLabel.Text = "Não autenticado";
            }
        }

        // Método para captura de foto
        private async void OnTakePhotoButtonClicked(object sender, EventArgs e)
        {
            var photo = await MediaPicker.CapturePhotoAsync();
            if (photo != null)
            {
                var stream = await photo.OpenReadAsync();
                await IdentifyPlant(stream);
            }
        }

        // Método para upload de imagem
        private async void OnUploadButtonClicked(object sender, EventArgs e)
        {
            var fileResult = await MediaPicker.PickPhotoAsync();
            if (fileResult != null)
            {
                var stream = await fileResult.OpenReadAsync();
                await IdentifyPlant(stream);
            }
        }

        // Método para identificar a planta com base na imagem
        private async Task IdentifyPlant(Stream photoStream)
        {
            // Verificar se _authClient está null
            if (_authClient == null)
            {
                await DisplayAlert("Erro", "_authClient está null", "OK");
                return;
            }

            // Limpar o CarouselView e o ResultLabel antes de adicionar novos dados
            ImageCarousel.ItemsSource = null;
            ResultLabel.Text = string.Empty;
            HealthStatusLabel.Text = string.Empty;

            var client = new HttpClient();
            var request = new HttpRequestMessage(HttpMethod.Post, plantIdIdentifyUrl);
            request.Headers.Add("Api-Key", plantIdApiKey);

            using (var memoryStream = new MemoryStream())
            {
                await photoStream.CopyToAsync(memoryStream);
                var base64Image = Convert.ToBase64String(memoryStream.ToArray());

                var jsonContent = new
                {
                    images = new[] { $"data:image/jpg;base64,{base64Image}" },
                    latitude = 49.207, // Use latitude from device if necessary
                    longitude = 16.608, // Use longitude from device if necessary
                    similar_images = true
                };

                var content = new StringContent(JsonSerializer.Serialize(jsonContent), System.Text.Encoding.UTF8, "application/json");
                request.Content = content;

                var response = await client.SendAsync(request);
                var result = await response.Content.ReadAsStringAsync();

                await DisplayAlert("Resposta da API", result, "OK"); // Exibir a resposta da API

                if (response.IsSuccessStatusCode)
                {
                    try
                    {
                        var plantInfo = JsonSerializer.Deserialize<PlantInfo>(result);

                        if (plantInfo?.Suggestions != null && plantInfo.IsPlant)
                        {
                            var plantName = plantInfo.Suggestions.FirstOrDefault()?.PlantName ?? "Desconhecido";

                            ResultLabel.Text = $"Nome: {plantName}";

                            // Chamar a função AssessPlantHealth para obter os detalhes da saúde da planta
                            var healthAssessment = await AssessPlantHealth(base64Image, 49.207, 16.608);
                            HealthStatusLabel.Text = healthAssessment;

                            // Adicionar a imagem do upload ao CarouselView
                            var images = new List<string>();
                            var uploadImageUrl = plantInfo.Images?.FirstOrDefault()?.Url;
                            if (!string.IsNullOrEmpty(uploadImageUrl))
                            {
                                images.Add(uploadImageUrl);
                            }

                            // Buscar a imagem da planta usando a Google Search API
                            var plantImageUrl = await FetchPlantImageUrl(plantName);
                            if (!string.IsNullOrEmpty(plantImageUrl))
                            {
                                images.Add(plantImageUrl);
                            }

                            // Use the new method to update images
                            UpdateImageDisplay(images);

                            await SavePlantInfoToFirebase(plantName, healthAssessment, uploadImageUrl, plantImageUrl);
                        }
                        else
                        {
                            await DisplayAlert("Sem Sugestões", "Nenhuma sugestão de planta foi encontrada.", "OK");
                            ResultLabel.Text = "Informações da planta não disponíveis.";
                        }
                    }
                    catch (JsonException ex)
                    {
                        await DisplayAlert("Erro", $"Erro ao desserializar JSON: {ex.Message}", "OK");
                    }
                }
                else
                {
                    await DisplayAlert("Erro", $"Erro na solicitação: {response.StatusCode}", "OK");
                }
            }
        }

        private async Task<string> AssessPlantHealth(string base64Image, double latitude, double longitude)
        {
            using var client = new HttpClient();
            var jsonContent = new
            {
                api_key = plantIdApiKey,
                images = new[] { base64Image },
                latitude = latitude,
                longitude = longitude
            };

            var content = new StringContent(JsonSerializer.Serialize(jsonContent), Encoding.UTF8, "application/json");

            try
            {
                var response = await client.PostAsync(plantIdHealthUrl, content);
                var result = await response.Content.ReadAsStringAsync();

                if (!response.IsSuccessStatusCode)
                {
                    UpdateHealthStatusDisplay("error", $"Error getting health assessment. Code: {response.StatusCode}");
                    return $"❌ Error getting health assessment. Code: {response.StatusCode}";
                }

                var healthInfo = JsonSerializer.Deserialize<PlantHealthApiResponse>(result);

                if (healthInfo?.HealthAssessment == null)
                {
                    UpdateHealthStatusDisplay("unknown", "Could not determine plant health status");
                    return "⚠️ Could not determine the health of the plant.";
                }

                if (healthInfo.HealthAssessment.IsHealthy)
                {
                    UpdateHealthStatusDisplay("healthy", $"Plant appears healthy! (Confidence: {healthInfo.HealthAssessment.IsHealthyProbability:P2})");
                    return $"✅ Plant appears healthy! (Confidence: {healthInfo.HealthAssessment.IsHealthyProbability:P2})";
                }

                if (healthInfo.HealthAssessment.Diseases != null && healthInfo.HealthAssessment.Diseases.Count > 0)
                {
                    string healthInfoText = "🚨 Problems detected:\n";
                    foreach (var disease in healthInfo.HealthAssessment.Diseases)
                    {
                        healthInfoText += $"- {disease.Name} (Probability: {disease.Probability:P2})\n";
                    }

                    UpdateHealthStatusDisplay("unhealthy", "Problems detected in plant", healthInfo.HealthAssessment.Diseases);
                    return healthInfoText;
                }

                UpdateHealthStatusDisplay("unknown", "Insufficient information about plant health");
                return "⚠️ Insufficient information about plant health.";
            }
            catch (Exception ex)
            {
                Console.WriteLine($"⚠️ Error processing health response: {ex.Message}");
                UpdateHealthStatusDisplay("error", "Error processing health assessment");
                return "Error processing health assessment.";
            }
        }

        private void UpdateHealthStatusDisplay(string status, string message, List<DiseaseDetected> diseases = null)
        {
            Device.BeginInvokeOnMainThread(() => {
                // Update the health status text
                HealthStatusLabel.Text = message;

                // Set the appropriate color and icon based on status
                switch (status.ToLower())
                {
                    case "healthy":
                        HealthStatusFrame.BackgroundColor = Color.FromHex("#E8F5E9");
                        HealthStatusIcon.Source = "health_good.png"; // Replace with your healthy icon
                        break;

                    case "unhealthy":
                        HealthStatusFrame.BackgroundColor = Color.FromHex("#FFEBEE");
                        HealthStatusIcon.Source = "health_warning.png"; // Replace with your warning icon
                        break;

                    case "error":
                        HealthStatusFrame.BackgroundColor = Color.FromHex("#FFEBEE");
                        HealthStatusIcon.Source = "error_icon.png"; // Replace with your error icon
                        break;

                    default: // unknown
                        HealthStatusFrame.BackgroundColor = Color.FromHex("#F5F5F5");
                        HealthStatusIcon.Source = "health_unknown.png"; // Replace with your unknown icon
                        break;
                }

                // Display disease details if available
                DiseaseDetailsStack.Children.Clear();

                if (diseases != null && diseases.Any())
                {
                    DiseaseDetailsStack.IsVisible = true;

                    // Add a header
                    DiseaseDetailsStack.Children.Add(new Label
                    {
                        Text = "DETECTED ISSUES",
                        FontSize = 12,
                        TextColor = Color.FromHex("#888"),
                        FontAttributes = FontAttributes.Bold,
                        Margin = new Thickness(0, 0, 0, 8)
                    });

                    // Add each disease as a separate item
                    foreach (var disease in diseases)
                    {
                        var diseaseFrame = new Frame
                        {
                            BackgroundColor = Color.FromHex("#FFF8E1"),
                            CornerRadius = 8,
                            HasShadow = false,
                            Padding = new Thickness(12),
                            BorderColor = Color.FromHex("#FFE0B2"),
                            Margin = new Thickness(0, 0, 0, 8)
                        };

                        var diseaseGrid = new Grid();

                        var diseaseName = new Label
                        {
                            Text = disease.Name,
                            FontSize = 14,
                            TextColor = Color.FromHex("#333"),
                            FontAttributes = FontAttributes.Bold
                        };

                        var probabilityLabel = new Label
                        {
                            Text = $"Probability: {disease.Probability:P0}",
                            FontSize = 12,
                            TextColor = Color.FromHex("#666"),
                            HorizontalOptions = LayoutOptions.End
                        };

                        diseaseGrid.Children.Add(diseaseName);
                        diseaseGrid.Children.Add(probabilityLabel);

                        diseaseFrame.Content = diseaseGrid;
                        DiseaseDetailsStack.Children.Add(diseaseFrame);
                    }
                }
                else
                {
                    DiseaseDetailsStack.IsVisible = false;
                }
            });
        }

        private void UpdateImageDisplay(List<string> imageUrls)
        {
            if (imageUrls != null && imageUrls.Any())
            {
                ImageCarousel.ItemsSource = null;
                ImageCarousel.ItemsSource = imageUrls;
                EmptyStateGrid.IsVisible = false;
            }
            else
            {
                ImageCarousel.ItemsSource = null;
                EmptyStateGrid.IsVisible = true;
            }
        }

        // Método para buscar a URL da imagem da planta usando a Google Search API
        private async Task<string> FetchPlantImageUrl(string plantName)
        {
            var apiKey = "AIzaSyB_5pTc2dywOeXg2gGb2cl1CrD1SZrtJhc"; // Sua chave de API
            var cx = "b4f2321f746c64db1"; // Substitua pelo seu ID do mecanismo de pesquisa
            var query = Uri.EscapeDataString(plantName);
            const string language = "PT-pt";

            var url = $"https://www.googleapis.com/customsearch/v1?q={query}&cx={cx}&searchType=image&key={apiKey}&hl={language}";

            var client = new HttpClient();
            var response = await client.GetAsync(url);
            var result = await response.Content.ReadAsStringAsync();

            if (response.IsSuccessStatusCode)
            {
                try
                {
                    var jsonDoc = JsonDocument.Parse(result);
                    var firstImageResult = jsonDoc.RootElement.GetProperty("items").EnumerateArray().FirstOrDefault();
                    if (firstImageResult.ValueKind != JsonValueKind.Undefined)
                    {
                        return firstImageResult.GetProperty("link").GetString();
                    }
                }
                catch (JsonException ex)
                {
                    await DisplayAlert("Erro", $"Erro ao desserializar JSON: {ex.Message}", "OK");
                }
            }
            else
            {
                await DisplayAlert("Erro", $"Erro na solicitação: {response.StatusCode}", "OK");
            }

            return null;
        }

        // Método para salvar informações no Firebase
        private async Task SavePlantInfoToFirebase(string plantName, string healthStatus, string userImageUrl, string defaultImageUrl)
        {
            var user = _authClient.User;
            if (user != null)
            {
                var plant = new
                {
                    Name = plantName,
                    HealthStatus = healthStatus,
                    UserImageUrl = userImageUrl,
                    DefaultImageUrl = defaultImageUrl
                };

                await DisplayAlert("Debug", "Antes de salvar no Firebase", "OK");

                await _firebaseClient
                    .Child("users")
                    .Child(user.Uid)
                    .Child("plants")
                    .PostAsync(plant);

                await DisplayAlert("Debug", "Depois de salvar no Firebase", "OK");
            }
            else
            {
                await DisplayAlert("Erro", "Usuário não autenticado.", "OK");
            }
        }

        // Definição das classes para processar a resposta da API
        public class PlantInfo
        {
            [JsonPropertyName("suggestions")]
            public List<Suggestion> Suggestions { get; set; }
            [JsonPropertyName("is_plant")]
            public bool IsPlant { get; set; }
            [JsonPropertyName("is_plant_probability")]
            public double IsPlantProbability { get; set; }
            [JsonPropertyName("images")]
            public List<ImageInfo> Images { get; set; }
        }

        public class Suggestion
        {
            [JsonPropertyName("plant_name")]
            public string PlantName { get; set; }
        }

        public class ImageInfo
        {
            [JsonPropertyName("url")]
            public string Url { get; set; }
        }

        public class PlantHealthApiResponse
        {
            [JsonPropertyName("health_assessment")]
            public HealthAssessment HealthAssessment { get; set; }
        }

        public class HealthAssessment
        {
            [JsonPropertyName("is_healthy")]
            public bool IsHealthy { get; set; }

            [JsonPropertyName("is_healthy_probability")]
            public double IsHealthyProbability { get; set; }

            [JsonPropertyName("diseases")]
            public List<DiseaseDetected> Diseases { get; set; }
        }

        public class DiseaseDetected
        {
            [JsonPropertyName("name")]
            public string Name { get; set; }

            [JsonPropertyName("probability")]
            public double Probability { get; set; }
        }

        private async void CheckAndRequestLocationPermission()
        {
            var status = await Permissions.CheckStatusAsync<Permissions.LocationWhenInUse>();
            if (status != PermissionStatus.Granted)
            {
                status = await Permissions.RequestAsync<Permissions.LocationWhenInUse>();
            }

            if (status == PermissionStatus.Granted)
            {
                // Permissão concedida, você pode acessar a localização
                await GetLocationAsync();
            }
            else
            {
                // Permissão negada, notifique o usuário
                await DisplayAlert("Permissão Negada", "Não foi possível acessar a localização. Por favor, habilite os serviços de localização.", "OK");
            }
        }

        private async Task GetLocationAsync()
        {
            try
            {
                var location = await Geolocation.GetLastKnownLocationAsync();
                if (location != null)
                {
                    // Use a localização
                    Console.WriteLine($"Latitude: {location.Latitude}, Longitude: {location.Longitude}");
                }
            }
            catch (FeatureNotSupportedException fnsEx)
            {
                // Handle not supported on device exception
                await DisplayAlert("Erro", "Serviço de localização não suportado no dispositivo.", "OK");
            }
            catch (FeatureNotEnabledException fneEx)
            {
                // Handle not enabled on device exception
                await DisplayAlert("Serviços de Localização Desativados", "Por favor, habilite os serviços de localização no seu dispositivo.", "OK");
            }
            catch (PermissionException pEx)
            {
                // Handle permission exception
                await DisplayAlert("Permissão Negada", "Permissão de localização negada. Por favor, conceda permissão para acessar a localização.", "OK");
            }
            catch (Exception ex)
            {
                // Unable to get location
                await DisplayAlert("Erro", "Não foi possível obter a localização. Tente novamente mais tarde.", "OK");
            }
        }

        private async void OnHistoricoButtonClicked(object sender, EventArgs e)
        {
            var user = _authClient.User;
            if (user != null)
            {
                await Navigation.PushAsync(new HistoricoPage(_firebaseClient, user.Uid));
            }
            else
            {
                await DisplayAlert("Erro", "Usuário não autenticado.", "OK");
            }
        }

        private async void OnMenuButtonClicked(object sender, EventArgs e)
        {
            await ToggleMenu();
        }

        private async Task ToggleMenu()
        {
            if (_isMenuOpen)
                await HideMenu();
            else
                await ShowMenu();
        }

        private async Task ShowMenu()
        {
            // Atualiza as informações do usuário antes de mostrar o menu
            UpdateUserInfo();
            
            DarkOverlay.IsVisible = true;

            // Animar o overlay
            _ = DarkOverlay.FadeTo(0.5, _animationLength, Easing.SinOut);

            // Animar o painel do menu
            await HamburgerMenuPanel.TranslateTo(0, 0, _animationLength, Easing.SinOut);
            _isMenuOpen = true;
        }

        private async Task HideMenu()
        {
            // Animar o overlay
            _ = DarkOverlay.FadeTo(0, _animationLength, Easing.SinIn);

            // Animar o painel do menu
            await HamburgerMenuPanel.TranslateTo(-280, 0, _animationLength, Easing.SinIn);

            DarkOverlay.IsVisible = false;
            _isMenuOpen = false;
        }

        private async void OnOverlayTapped(object sender, EventArgs e)
        {
            await HideMenu();
        }

        private async void OnHomeMenuItemTapped(object sender, EventArgs e)
        {
            await HideMenu();
            // Já estamos na página inicial, não é necessário navegar
        }

        private async void OnProfileMenuItemTapped(object sender, EventArgs e)
        {
            await HideMenu();
            await Navigation.PushAsync(new ProfileDetails());
        }

        private async void OnWeatherMenuItemTapped(object sender, EventArgs e)
        {
            await HideMenu();
            await Navigation.PushAsync(new TempoPage());
        }

        private async void OnHistoryMenuItemTapped(object sender, EventArgs e)
        {
            await HideMenu();
            var user = _authClient.User;
            if (user != null)
            {
                await Navigation.PushAsync(new HistoricoPage(_firebaseClient, user.Uid));
            }
            else
            {
                await DisplayAlert("Erro", "Usuário não autenticado.", "OK");
            }
        }

        private void OnSettingsButtonClicked(object sender, EventArgs e)
        {
            // Handle settings button click here
            // Implemente aqui a navegação para a página de configurações
            // Por exemplo: Navigation.PushAsync(new SettingsPage());
        }
    }
}