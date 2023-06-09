import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_convert_app/provider/ThemeProvider.dart';
import 'package:platform_convert_app/views/screens/CupertinoAppPage.dart';
import 'package:platform_convert_app/views/screens/MaterialAppPage.dart';
import 'package:platform_convert_app/views/screens/SplashScreenPage.dart';
import 'package:provider/provider.dart';
import 'provider/GlobalProvider.dart';

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
          create: (context) => GlobalProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      builder: (context, _) =>
          (Provider.of<GlobalProvider>(context).IsIos == true)
              ? const CupertinoApp(

                  debugShowCheckedModeBanner: false,
                  home: CupertinoAppPage(),
                )
              : MaterialApp(
                  theme: ThemeData.light(
                    useMaterial3: true,
                  ),
                  darkTheme: ThemeData.dark(
                    useMaterial3: true,
                  ),
                  themeMode:
                      (Provider.of<ThemeProvider>(context).isDark == true)
                          ? ThemeMode.dark
                          : ThemeMode.light,
                  debugShowCheckedModeBanner: false,
                  routes: {
                    '/': (context) => const MaterialAppPage(),
                    'SplashScreenPage': (context) => const SplashScreenPage(),
                  },
                ),
    );
  }
}
