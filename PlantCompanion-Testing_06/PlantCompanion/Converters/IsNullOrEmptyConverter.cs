using System;
using System.Collections;
using System.Globalization;
using Microsoft.Maui.Controls;

namespace PlantCompanion.Converters
{
    public class IsNullOrEmptyConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value == null)
                return true;
            
            if (value is ICollection collection)
                return collection.Count == 0;
                
            return false;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}