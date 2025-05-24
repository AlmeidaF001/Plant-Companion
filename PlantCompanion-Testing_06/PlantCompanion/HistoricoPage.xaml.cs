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
                Key = p.Key,
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

                // Reload plant history
                LoadPlantHistory();
            }
        }

        private async void OnRefreshing(object sender, EventArgs e)
        {
            refreshView.IsRefreshing = true;

            try
            {
                await LoadPlantHistoryAsync();
            }
            finally
            {
                refreshView.IsRefreshing = false;
            }
        }

        private async Task LoadPlantHistoryAsync()
        {
            var plants = await GetPlantHistoryAsync();
            PlantsCollectionView.ItemsSource = plants;
            
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
                var allPlants = await GetPlantHistoryAsync();
                PlantsCollectionView.ItemsSource = allPlants;
            }
            else
            {
                var allPlants = await GetPlantHistoryAsync();
                var filteredPlants = allPlants.Where(p => 
                    p.Name?.ToLower().Contains(searchText) == true || 
                    p.HealthStatus?.ToLower().Contains(searchText) == true).ToList();
                
                PlantsCollectionView.ItemsSource = filteredPlants;
            }
        }

        private async void OnViewDetailsClicked(object sender, EventArgs e)
        {
            var button = sender as Button;
            var plant = button?.CommandParameter as Plant;
            
            if (plant != null)
            {
                // Navigate to plant details page
                await Shell.Current.GoToAsync($"//plantdetails?id={plant.Key}");
            }
        }

        private async void OnScanPlantClicked(object sender, EventArgs e)
        {
            // Navigate back to main page with camera functionality
            await Shell.Current.GoToAsync("//main");
        }

        public class Plant
        {
            public string Key { get; set; }
            public string Name { get; set; }
            public string HealthStatus { get; set; }
            public string UserImageUrl { get; set; }
            public string DefaultImageUrl { get; set; }
        }
    }
}