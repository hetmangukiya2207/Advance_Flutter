

import 'package:flutter/material.dart';
import 'package:goverment_service_app/Provider/ConnectionProvider.dart';
import 'package:goverment_service_app/views/screens/BingPage.dart';
import 'package:goverment_service_app/views/screens/DuckDuckGoPage.dart';
import 'package:goverment_service_app/views/screens/GooglePage.dart';
import 'package:goverment_service_app/views/screens/YahooPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectionProvider()),
      ],
      child: Builder(
        builder: (context) {
          return const MyApp();
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const GooglePage(),
        'YahooPage': (context) => const YahooPage(),
        'BingPage': (context) => const BingPage(),
        'DuckDuckGoPage': (context) => const DuckDuckPage(),
      },
    );
  }
}

