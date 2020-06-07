import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/location.dart';

class WeatherModel {
  dynamic weatherData;
  Future<dynamic> getWeatherData() async {
    Location location = Location();
    //Gets the user's current location.
    await location.getCurrentLocation();
    double latitude = location.latitude;
    double longitude = location.longitude;
    //Creates a NetworkHelper object based on the long/lat from getCurrentLocation() call.
    //This line demonstrates why it's good practice to make a variable out of classes.
    //Otherwise, I would have to paste the url property each time I wanted to create a NetworkHelper object.
    NetworkHelper networkHelper = NetworkHelper(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=imperial');

    weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        url:
            'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=imperial');
    dynamic weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 75) {
      return 'It\'s 🍦 time';
    } else if (temp > 65) {
      return 'Time for shorts and 👕';
    } else if (temp > 40) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
