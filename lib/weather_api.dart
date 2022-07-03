import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/weather.dart';

class WeatherApi {
  WeatherApi._privateConstructor();

  static final WeatherApi instance = WeatherApi._privateConstructor();
  final Constants _constants = Constants();

  factory WeatherApi() {
    return instance;
  }

  late Position _position;

  ///Returns Weather class
  Future<Weather> fetchWeatherFromPosition() async {
    _position = await Location.instance.determinePosition();
    final weatherResponse = await http.get(
      Uri.parse(
          '${_constants.baseUrl}current.json?key=${_constants.apiKey}&q=${_position.longitude},${_position.latitude}&aqi=yes'),
    );

    if (weatherResponse.statusCode == 200) {
      return Weather.fromJson(jsonDecode(weatherResponse.body));
    } else {
      throw Exception("Could not load data");
    }
  }

  Future<Weather> fetchWeatherFromCity(String cityName)async {
      final weatherResponse = await http.get(
      Uri.parse(
          '${_constants.baseUrl}current.json?key=${_constants.apiKey}&q=$cityName&aqi=yes'),
    );

    if (weatherResponse.statusCode == 200) {
      return Weather.fromJson(jsonDecode(weatherResponse.body));
    } else {
      throw Exception("Could not load data");
    }
  }
}
