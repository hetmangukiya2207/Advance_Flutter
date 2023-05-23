import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  bool isGridView = false;
  bool isDarkView = false;

  changeView() {
    isGridView = !isGridView;
    notifyListeners();
  }

  changeTheme() {
    isDarkView = !isDarkView;
    notifyListeners();
  }
}