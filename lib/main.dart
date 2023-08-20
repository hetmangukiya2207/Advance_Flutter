import 'package:flutter/material.dart';
import 'category_author_page.dart';
import 'details_page.dart';
import 'homepage.dart';
import 'quotes_page.dart';
import 'splash_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash_screen',
      routes: {
        'splash_screen': (context) => const SplashScreen(),
        '/': (context) => const HomePage(),
        'details_page': (context) => const DetailsPage(),
        'category_author_page': (context) => const CategoryOrAuthorPage(),
        'quotes_page': (context) => const QuotesPage(),
      },
    ),
  );
}
