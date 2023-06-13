import 'dart:async';

class ConnectionModel {
  String ConnectStatus;
  StreamSubscription? ConnectStream;

  ConnectionModel({
    required this.ConnectStatus,
    this.ConnectStream,
  } );
}
