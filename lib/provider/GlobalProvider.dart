import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ott_app_platform_app/models/ConnectionModel.dart';

class GlobalProvider extends ChangeNotifier {
  InAppWebViewController? inAppWebViewController;

  void AppWebController (InAppWebViewController n)
  {
    inAppWebViewController = n;
  }
}