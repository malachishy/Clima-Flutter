import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;

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
  double latitude = location.latitude;
  double longitude = location.longitude;
  print(latitude);
  print(longitude);
}

void getData() async {
  http.Response response = await http.get(
      'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=439d4b804bc8187953eb36d2a8c26a02');
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print(response.statusCode);
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
    getData();
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
