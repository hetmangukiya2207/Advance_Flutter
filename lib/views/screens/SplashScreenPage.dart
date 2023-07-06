import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/ImageUtils.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Duration duration = Duration(seconds: 3);

    Timer(duration, () {
      Navigator.of(context).pushReplacementNamed('OneTimeIntroScreenPage');
    });
  }
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      body: Center(
        child: Image.asset(ImagePath + AppIcon,fit: BoxFit.cover,),
      ),
      backgroundColor: Color(0xff0587fc),
    );
  }
}
