import 'dart:async';

class ConnectionModel {
  String connectStatus;
  StreamSubscription? connectStrean;

  ConnectionModel({required this.connectStatus, this.connectStrean});
}
