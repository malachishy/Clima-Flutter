import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
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
    goToLocationScreen();
    print('Loading Screen');
  }

  void goToLocationScreen() async {
    Location location = Location();
    await location.getLocationData();
    //Switches to the LocationScreen() route.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(location.weatherData),
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
