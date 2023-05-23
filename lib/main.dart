import 'package:flutter/material.dart';
import 'package:intro_screen_using_package/views/screen/HomePage.dart';
import 'package:intro_screen_using_package/views/screen/IntoScreenPage.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'IntroScreen',
      routes: {
        '/' : (context) => const HomePage(),
        'IntroScreen' : (context) => const IntroScreenPage(),
      },
    );
  }
}
