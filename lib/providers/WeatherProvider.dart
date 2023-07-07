import 'package:flutter/material.dart';

import '../helpers/ApiHelpers.dart';
import '../models/SearchLocationModel.dart';
import '../models/WeatherModel.dart';

class WeatherProvider extends ChangeNotifier {
  SearchLocation searchLocation = SearchLocation(
    location: "Surat",
    locationController: TextEditingController(),
  );

  searchWeather(String location) {
    searchLocation.location = location;
    notifyListeners();
  }

  Future<Weather?>? weatherData(String location) async {
    searchLocation.weather =
    (await APIHelper.apiHelper.fetchWeatherDetails(location));
    return searchLocation.weather;
  }
}