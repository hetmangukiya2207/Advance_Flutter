import 'dart:async';

class ConnectivityModel {
  String connectivityStatus;
  StreamSubscription? connectivityStream;

  ConnectivityModel({
    required this.connectivityStatus,
    this.connectivityStream,
  });
}
