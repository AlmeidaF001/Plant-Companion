namespace PlantCompanion;

public partial class ProfileDetails : ContentPage
{
    public ProfileDetails()
    {
        InitializeComponent();


    }

    private async void OnCameraButtonClicked(object sender, EventArgs e)
    {
        try
        {
            var result = await MediaPicker.PickPhotoAsync(new MediaPickerOptions
            {
                Title = "Select Profile Picture"
            });

            if (result != null)
            {
                // Load the selected image into the profile image
                var stream = await result.OpenReadAsync();
                profileImage.Source = ImageSource.FromStream(() => stream);
                
                // Here you would typically upload this image to storage
                // and update the user's profile in your database
                // await UploadProfileImageAsync(result.FullPath);
            }
        }
        catch (Exception ex)
        {
            // Handle exceptions, e.g., permissions issues
            await DisplayAlert("Error", $"Unable to select image: {ex.Message}", "OK");
        }
    }

    private void OnTogglePasswordVisibilityClicked(object sender, EventArgs e)
    {
        // Toggle the IsPassword property to show/hide the password
        entryPassword.IsPassword = !entryPassword.IsPassword;
        
        // You might also want to change the icon based on visibility state
        var button = sender as ImageButton;
        if (button != null)
        {
            button.Source = entryPassword.IsPassword ? "eye_icon.png" : "eye_off_icon.png";
        }
    }

    private void OnToggleConfirmPasswordVisibilityClicked(object sender, EventArgs e)
    {
        // Toggle the IsPassword property to show/hide the confirm password
        entryConfirmPassword.IsPassword = !entryConfirmPassword.IsPassword;
        
        // You might also want to change the icon based on visibility state
        var button = sender as ImageButton;
        if (button != null)
        {
            button.Source = entryConfirmPassword.IsPassword ? "eye_icon.png" : "eye_off_icon.png";
        }
    }
}