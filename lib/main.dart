import 'package:bhagvat_geeta/controllers/providers/json_decode_provider.dart';
import 'package:bhagvat_geeta/models/theme_model.dart';
import 'package:bhagvat_geeta/views/screens/AllVersesPage.dart';
import 'package:bhagvat_geeta/views/screens/ChapterDetailPage.dart';
import 'package:bhagvat_geeta/views/screens/ShlokDetailPage.dart';
import 'package:bhagvat_geeta/views/screens/SplashScreen.dart';
import 'package:bhagvat_geeta/views/screens/HomePage.dart';
import 'package:bhagvat_geeta/controllers/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isDark = prefs.getBool('appTheme') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            themeModel: ThemeModel(
              isDark: isDark,
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ChapterJsonDecodeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShlokJsonDecodeProvider(),
        ),
      ],
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: (Provider.of<ThemeProvider>(context).themeModel.isDark)
            ? ThemeMode.dark
            : ThemeMode.light,
        routes: {
          '/': (context) => const SplashScreen(),
          'Home_Page': (context) => const HomePage(),
          'chapter_detail_page': (context) => const ChapterDetailPage(),
          'all_verses_page': (context) => const AllVersesPage(),
          'shlok_detail_page': (context) => const ShlokDetailPage(),
        },
      ),
    ),
  );
}
