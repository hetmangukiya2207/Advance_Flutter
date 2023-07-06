import 'dart:async';

class ConnectionModel {
  String connectivityStatus;
  StreamSubscription? connectivityStream;

  ConnectionModel({
    required this.connectivityStatus,
    this.connectivityStream,
  });
}