import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/services/location.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen(this.locationWeather);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String cityName;
  int temperature;
  int condition;
  dynamic weatherData;
  String weatherIcon;
  String weatherMessage;

  @override
  void initState() {
    super.initState();
    //?When I moved this inside the build() method, the app screen didn't update when I pressed
    //?location button. Why? I thought setState updated everything inside of the build method.
    //*That's exactly why! It's because I had explicity called updateUI(widget.locationWeather)
    //*inside of the build method. So when the state was set, it was set based on that instance
    //*of my updateUI() method, I think.
    updateUI(widget.locationWeather);
  }

//Variables that are initialized inside methods only exist within that method.
//Variables that are updated inside a method keep this updated value even outside the method.
  void updateUI(dynamic wData) {
    setState(() {
      if (wData == null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(
                'Location services are disabled. Please enable in settings.'),
          ),
        );
      }
      cityName = wData['name'];
      double temp = wData['main']['temp'];
      condition = wData['weather'][0]['id'];
      temperature = temp.toInt();
      weatherIcon = WeatherModel().getWeatherIcon(condition);
      weatherMessage = WeatherModel().getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      weatherData = await Location().getLocationData();
                      updateUI(weatherData);
                      print(cityName);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      Future<String> cityInput = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      print(cityInput);
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.left,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
