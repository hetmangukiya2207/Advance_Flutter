import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkView = false;

  changeTheme() {
    isDarkView = !isDarkView;
    notifyListeners();
  }
}