import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class CityDatabase {
  CityDatabase._privateConstructor();
  static final CityDatabase instance = CityDatabase._privateConstructor();
  factory CityDatabase() {
    return instance;
  }

  List<City> database = [];

  Future<void> initialise() async {
    final String response = await readJson();
    final List<dynamic> data = jsonDecode(response);
    List<Map<String,dynamic>> requiredData = data.map((e) => Map<String, dynamic>.from(e)).toList();
    database = await compute(parseJsonToCity, requiredData);
  }

  Future<String> readJson() async {
    final String response = await rootBundle.loadString('database/cities.json');
    return response;
  }

  static List<City> parseJsonToCity(List<Map<String, dynamic>> json) {
    List<City> requiredData = json.map((data) => City.fromMap(data)).toList();
    return requiredData;
  }
}

class City {
  City({
    required this.city,
    required this.cityAscii,
    required this.lat,
    required this.lng,
    required this.country,
    required this.iso2,
    required this.iso3,
    required this.adminName,
    required this.capital,
    required this.population,
    required this.id,
  });

  final String city;
  final String cityAscii;
  final double lat;
  final double lng;
  final String country;
  final String iso2;
  final String iso3;
  final String adminName;
  final String capital;
  final int population;
  final int id;

  factory City.fromMap(Map<String, dynamic> json) => City(
        city: json["city"],
        cityAscii: json["city_ascii"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        country: json["country"],
        iso2: json["iso2"],
        iso3: json["iso3"],
        adminName: json["admin_name"],
        capital: json["capital"],
        population: json["population"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "city": city,
        "city_ascii": cityAscii,
        "lat": lat,
        "lng": lng,
        "country": country,
        "iso2": iso2,
        "iso3": iso3,
        "admin_name": adminName,
        "capital": capital,
        "population": population,
        "id": id,
      };
}
