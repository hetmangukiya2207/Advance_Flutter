import 'package:flutter/material.dart';

class ConnectionProvider extends ChangeNotifier {
  String? radio = "g";

  void ChangeRadio(String n) {
    radio = n;
    notifyListeners();
  }
}
