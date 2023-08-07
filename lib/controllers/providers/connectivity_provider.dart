import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:search_engine/models/connectivity_model.dart';

class ConnectivityProvider extends ChangeNotifier {
  Connectivity connectivity = Connectivity();

  ConnectivityModel connectivityModel =
      ConnectivityModel(connectivityStatus: "waiting");

  void checkInternetConnectivity() {
    connectivityModel.connectivityStream = connectivity.onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        connectivityModel.connectivityStatus = "WiFi";
        notifyListeners();
      } else if (connectivityResult == ConnectivityResult.mobile) {
        connectivityModel.connectivityStatus = "MobileData";
        notifyListeners();
      } else {
        connectivityModel.connectivityStatus = "waiting";
        notifyListeners();
      }
    });
  }
}
