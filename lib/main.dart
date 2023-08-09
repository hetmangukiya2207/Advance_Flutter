import 'package:budget_tracker_app/views/screens/homepage.dart';
import 'package:budget_tracker_app/views/screens/page1.dart';
import 'package:budget_tracker_app/views/screens/page2.dart';
import 'package:budget_tracker_app/views/screens/page3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main(){
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
    getPages: [
      GetPage(name: '/',page: () => HomePage(),),
      GetPage(name: '/page1',page: () => Page1(),),
      GetPage(name: '/page2',page: () => Page2(),),
      GetPage(name: '/page3',page: () => Page3(),),
    ],
  ));
}