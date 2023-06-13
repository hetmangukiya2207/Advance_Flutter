import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:ott_app_platform_app/models/ConnectionModel.dart';

class ConnectionProvider extends ChangeNotifier {
  Connectivity connectivity = Connectivity();
  ConnectionModel connectionModel = ConnectionModel(ConnectStatus: "Waiting");

  void CheckInternet() {
    connectionModel.ConnectStream = connectivity.onConnectivityChanged.listen((
        ConnectivityResult connectivityResult) {
      switch (connectivityResult) {
        case ConnectivityResult.mobile :
          connectionModel.ConnectStatus = "Mobile";
          notifyListeners();
          break;

        case ConnectivityResult.wifi :
          connectionModel.ConnectStatus = "wifi";
          notifyListeners();
          break;

        default :
          connectionModel.ConnectStatus = "Waiting";
      }
    });
  }
}