import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

// This method should:
//  1. Create a new Location object.
// This means an object of class Location.
//  2. Call the getCurrentLocation() method.
//  3. Print the values stored inside latitude and longitude.
void getLocation() async {
  Location location = Location();
  await location.getCurrentLocation();
  print(location.latitude);
  print(location.longitude);
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {},
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
