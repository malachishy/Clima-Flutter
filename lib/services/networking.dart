import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//This class is very flexible because its functionality is not limited to only weather data.
//It can be used for any networking capability we need in the future.
//It would be smart to save this file for future reference.

class NetworkHelper {
  final String url;

  NetworkHelper({@required this.url});

  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodeData = jsonDecode(data);
      return decodeData;
    } else {
      print(response.statusCode);
    }
  }
}
