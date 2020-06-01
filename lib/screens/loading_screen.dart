import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/screens/location_screen.dart';

const String apiKey = '739d568c0baa232676ff5e8372ce16ec';

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
  }

  Future getLocationData() async {
    //Gets the user's current location.
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    //Creates a NetworkHelper object based on the long/lat from getCurrentLocation() call.
    //This line demonstrates why it's good practice to make a variable out of classes.
    //Otherwise, I would have to paste the url property each time I wanted to create a NetworkHelper object.
    NetworkHelper networkHelper = NetworkHelper(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    var weatherData = await networkHelper.getData();
    //Switches to the LocationScreen() route.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            print('Hello World!');
            await getLocationData();
            print(latitude);
            print(longitude);
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
