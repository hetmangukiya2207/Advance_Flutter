import 'package:ad_exam_1/provider/ConnectionProvider.dart';
import 'package:ad_exam_1/views/screens/HomePage.dart';
import 'package:ad_exam_1/views/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectionProvider(),
        ),
      ],
      builder: (context, _) => MaterialApp(
        themeMode: ThemeMode.system,
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        initialRoute: 'SplashScreen',
        routes: {
          '/': (context) => HomePage(),
          'SplashScreen': (context) => SplashScreen(),
        },
      ),
    );
  }
}
