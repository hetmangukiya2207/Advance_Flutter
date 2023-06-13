import 'package:flutter/material.dart';
import 'package:ott_app_platform_app/provider/ConnectionProvider.dart';
import 'package:ott_app_platform_app/views/screens/HomePage.dart';
import 'package:ott_app_platform_app/views/screens/OTTPlatformScreen.dart';
import 'package:ott_app_platform_app/views/screens/SplashScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectionProvider(),
        ),
      ],
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: 'SplashScreenPage',
      routes: {
        'SplashScreenPage': (context) => const SplashScreen(),
        'OTTPlatformScreen': (context) => const OTTPlatformScreen(),
        '/': (context) => const HomePage(),
      },
    );
  }
}
