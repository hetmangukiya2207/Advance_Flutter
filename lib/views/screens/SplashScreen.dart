import 'dart:async';

import 'package:chat_app_using_firebase/views/utils/ImageUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

    Timer(
        const Duration(
          seconds: 3,
        ), () {
      Get.offAllNamed('/LoginPage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: Get.height * 0.8,
            width: Get.width * 0.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImagePath + AppLogo,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
