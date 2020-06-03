import 'package:geolocator/geolocator.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/utilities/constants.dart';

class Location {
  double latitude;
  double longitude;
  var weatherData;

  Location({this.latitude, this.longitude});

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getLocationData() async {
    //Gets the user's current location.
    await getCurrentLocation();
    print(latitude);
    print(longitude);
    //Creates a NetworkHelper object based on the long/lat from getCurrentLocation() call.
    //This line demonstrates why it's good practice to make a variable out of classes.
    //Otherwise, I would have to paste the url property each time I wanted to create a NetworkHelper object.
    NetworkHelper networkHelper = NetworkHelper(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=imperial');

    weatherData = await networkHelper.getData();

    return weatherData;
  }
}
