import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sky_scrapper/providers/ConnectionProvider.dart';
import 'package:sky_scrapper/views/screens/HomePage.dart';
import 'package:sky_scrapper/views/screens/OneTimeIntroScreenPage.dart';
import 'package:sky_scrapper/views/screens/SplashScreenPage.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectionProvider(),
        ),
      ],
      builder: (context, _) => MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialRoute: 'SplashScreenPage',
        routes: {
          '/': (context) => const HomePage(),
          'OneTimeIntroScreenPage': (context) => OneTimeIntroScreenPage(),
          'SplashScreenPage': (context) => const SplashScreenPage(),
        },
      ),
    );
  }
}
