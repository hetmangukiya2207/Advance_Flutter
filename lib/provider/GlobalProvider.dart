import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class GlobalProvider extends ChangeNotifier{
  bool IsIos = false;
  bool Profile = false;
  bool Theme = false;

  int index = 0;

  DateTime initialDate = DateTime.now();

  TimeOfDay initialTime = TimeOfDay.now();

  void SwitchBtn (bool n) {
    IsIos = n;
    notifyListeners();
  }

  void ProfileBtn (bool n) {
    Profile = n;
    notifyListeners();
  }

  void ThemeBtn (bool n) {
    Theme = n;

    (Theme == true) ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true) ;
    notifyListeners();
  }

  void CurIndex (int n) {
    index = n;
    notifyListeners();
  }

  void PickedDate (DateTime n)
  {
    initialDate = n;
    notifyListeners();
  }

  void PickedTime (TimeOfDay n)
  {
    initialTime = n;
    notifyListeners();
  }
}