import 'package:flutter/cupertino.dart';

class ThemeProvider extends ChangeNotifier{

  bool isDark = false;

  void ChangeAppTheme (bool n) async{
    isDark = n;
    notifyListeners();
  }
}