using Firebase.Database;
using Firebase.Database.Query;
using Microsoft.Maui.Controls;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PlantCompanion
{
    public partial class HistoricoPage : ContentPage
    {
        private readonly FirebaseClient _firebaseClient;
        private readonly string _userId;

        public HistoricoPage(FirebaseClient firebaseClient, string userId)
        {
            InitializeComponent();
            _firebaseClient = firebaseClient;
            _userId = userId;
            LoadPlantHistory();
        }

        private async void LoadPlantHistory()
        {
            var plants = await GetPlantHistoryAsync();
            PlantsCollectionView.ItemsSource = plants;
        }

        private async Task<List<Plant>> GetPlantHistoryAsync()
        {
            var plants = await _firebaseClient
                .Child("users")
                .Child(_userId)
                .Child("plants")
                .OnceAsync<Plant>();

            return plants.Select(p => new Plant
            {
                Key = p.Key, // Adicionando a propriedade Key
                Name = p.Object.Name,
                HealthStatus = p.Object.HealthStatus,
                UserImageUrl = p.Object.UserImageUrl,
                DefaultImageUrl = p.Object.DefaultImageUrl
            }).ToList();
        }

        private async void OnDeleteButtonClicked(object sender, EventArgs e)
        {
            var button = sender as Button;
            var plant = button?.CommandParameter as Plant;
            if (plant != null)
            {
                await _firebaseClient
                    .Child("users")
                    .Child(_userId)
                    .Child("plants")
                    .Child(plant.Key)
                    .DeleteAsync();

                // Recarregar o histórico de plantas
                LoadPlantHistory();
            }
        }

        private async void OnRefreshing(object sender, EventArgs e)
        {
            // Show refresh indicator
            refreshView.IsRefreshing = true;

            try
            {
                // Reload your plant history data here
                await LoadPlantHistoryAsync();
            }
            catch (Exception ex)
            {
                // Handle any exceptions that occur during refresh
                await DisplayAlert("Error", $"Failed to refresh plant history: {ex.Message}", "OK");
            }
            finally
            {
                // Always hide the refresh indicator when done
                refreshView.IsRefreshing = false;
            }
        }

        private async Task LoadPlantHistoryAsync()
        {
            // Use your existing method
            var plants = await GetPlantHistoryAsync();
            PlantsCollectionView.ItemsSource = plants;
            
            // Apply any existing search filter if needed
            if (!string.IsNullOrWhiteSpace(SearchEntry.Text))
            {
                OnSearchTextChanged(SearchEntry, new TextChangedEventArgs(null, SearchEntry.Text));
            }
        }

        private async void OnSearchTextChanged(object sender, TextChangedEventArgs e)
        {
            string searchText = e.NewTextValue?.ToLower() ?? string.Empty;
            
            if (string.IsNullOrWhiteSpace(searchText))
            {
                // If search field is empty, show all plants
                var allPlants = await GetPlantHistoryAsync();
                PlantsCollectionView.ItemsSource = allPlants;
            }
            else
            {
                // Filter plants by name
                var allPlants = await GetPlantHistoryAsync();
                var filteredPlants = allPlants.Where(p => 
                    p.Name?.ToLower().Contains(searchText) == true || 
                    p.HealthStatus?.ToLower().Contains(searchText) == true).ToList();
                
                PlantsCollectionView.ItemsSource = filteredPlants;
            }
        }

        // Add this method for the "View Details" button
        private async void OnViewDetailsClicked(object sender, EventArgs e)
        {
            var button = sender as Button;
            var plant = button?.CommandParameter as Plant;
            
            if (plant != null)
            {
                // Placeholder implementation - display some basic plant details
                await DisplayAlert(
                    $"{plant.Name} Details",
                    $"Health Status: {plant.HealthStatus}",
                    "Close");
                    
                // When you implement a details page, you would navigate to it like this:
                // await Navigation.PushAsync(new PlantDetailsPage(plant));
            }
        }

        // Add this method for the "Scan a Plant" button in empty state
        private async void OnScanPlantClicked(object sender, EventArgs e)
        {
            // Navigate to the scan or camera page
            // This is just a placeholder - update to navigate to your actual camera/scan page
            await DisplayAlert("Scan Plant", 
                "This would navigate to the plant scanning functionality. " + 
                "Update this method to navigate to your camera/scanning page.", 
                "OK");
            
            // When you implement navigation, it might look like:
            // await Navigation.PushAsync(new ScanPlantPage());
            // or
            // await Shell.Current.GoToAsync("//scan");
        }

        public class Plant
        {
            public string Key { get; set; } // Adicionando a propriedade Key
            public string Name { get; set; }
            public string HealthStatus { get; set; }
            public string UserImageUrl { get; set; }
            public string DefaultImageUrl { get; set; }
        }
    }
}