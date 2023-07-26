import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Duration duration = Duration(seconds: 3);

    Timer(duration, () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/',
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: h,
            width: w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/main2.jpg',
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
              child: Text(
                "OUR GALAXY APP",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: h * 0.035,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
