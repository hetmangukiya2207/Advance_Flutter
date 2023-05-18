import 'package:advance_flutter/provider/CounterProvider.dart';
import 'package:advance_flutter/views/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<CounterProvider>(
      create: (context) => CounterProvider(),
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        routes: {
          '/': (context) => const HomePage(),
        },
      ),
    ),
  );
}
