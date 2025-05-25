namespace PlantCompanion;

[QueryProperty(nameof(PlantId), "id")]
[QueryProperty(nameof(PlantName), "name")]
[QueryProperty(nameof(PlantHealthStatus), "healthStatus")]
[QueryProperty(nameof(PlantImageUrl), "imageUrl")]
public partial class PerfilPage : ContentPage
{
    // Adicione essas propriedades
    public string PlantId { get; set; }
    public string PlantName { get; set; }
    public string PlantHealthStatus { get; set; }
    public string PlantImageUrl { get; set; }

    public PerfilPage()
    {
        InitializeComponent();
    }

    // Resto do código existente

    // Adicione esse método para carregar os detalhes da planta
    protected override void OnPropertyChanged(string propertyName = null)
    {
        base.OnPropertyChanged(propertyName);
    }

    protected override void OnAppearing()
    {
        base.OnAppearing();
        
        if (!string.IsNullOrEmpty(PlantName))
        {
            Title = PlantName;
            // Exiba as informações conforme sua UI atual permite
            DisplayAlert("Detalhes da Planta", 
                $"Nome: {PlantName}\nEstado de Saúde: {PlantHealthStatus}", 
                "OK");
        }
    }
}