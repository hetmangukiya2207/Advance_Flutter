import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/ImageUtils.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Duration duration = const Duration(seconds: 3);

    Timer (duration, () {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImagePath + P1),
          SizedBox(
            height: h * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "HR Mangukiya",
                  style: TextStyle(
                    fontSize: h * 0.02,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: w * 0.04,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
