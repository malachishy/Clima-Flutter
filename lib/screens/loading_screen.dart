import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/screens/location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

// This method should:
//  1. Create a new Location object.
// This means an object of class Location.
//  2. Call the getCurrentLocation() method.
//  3. Print the values stored inside latitude and longitude.

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    print('Loading Screen');
    goToLocationScreen();
  }

  void goToLocationScreen() async {
    WeatherModel weatherModel = WeatherModel();
    await weatherModel.getWeatherData();
    //Switches to the LocationScreen() route.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(weatherModel.weatherData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(
            Colors.white,
          ),
        ),
      ),
    );
  }
}
