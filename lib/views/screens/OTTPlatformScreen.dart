import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ott_app_platform_app/provider/ConnectionProvider.dart';
import 'package:ott_app_platform_app/provider/GlobalProvider.dart';
import 'package:provider/provider.dart';
import '../utils/ImageUtils.dart';

class OTTPlatformScreen extends StatefulWidget {
  const OTTPlatformScreen({Key? key}) : super(key: key);

  @override
  State<OTTPlatformScreen> createState() => _OTTPlatformScreenState();
}

class _OTTPlatformScreenState extends State<OTTPlatformScreen> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return SafeArea(
      child: Scaffold(
        body: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(
                    data['Url'],
                  ),
                ),
                onLoadStart: (Controller, uri) {
                  Provider.of<GlobalProvider>(context).inAppWebViewController;
                },
                onLoadStop: (Controller, uri) {},
              ),
      ),
    );
  }
}
