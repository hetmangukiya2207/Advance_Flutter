import 'package:flutter/material.dart';

import 'WeatherModel.dart';

class SearchLocation {
  String location;
  Weather? weather;
  TextEditingController locationController;

  SearchLocation({
    required this.location,
    this.weather,
    required this.locationController,
  });
}