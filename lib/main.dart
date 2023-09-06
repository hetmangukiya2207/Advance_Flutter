import 'package:chat_app_using_firebase/views/screens/ChatPage.dart';
import 'package:chat_app_using_firebase/views/screens/HomePage.dart';
import 'package:chat_app_using_firebase/views/screens/LoginPage.dart';
import 'package:chat_app_using_firebase/views/screens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/SplashScreen',
      getPages: [
        GetPage(
          name: "/SplashScreen",
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: "/",
          page: () => const HomePage(),
        ),
        GetPage(
          name: "/LoginPage",
          page: () => const LoginPage(),
        ),
        GetPage(
          name: "/ChatPage",
          page: () => const ChatPage(),
        ),
      ],
    );
  }
}
