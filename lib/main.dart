import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_system/providder/ThemeProvider.dart';
import 'package:solar_system/screen/SplashScreen.dart';
import 'package:solar_system/screen/detailscreen.dart';
import 'package:solar_system/screen/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: (Provider.of<ThemeProvider>(context).isDarkView != true)
            ? ThemeData.light()
            : ThemeData.dark(),
        initialRoute: 'SplashScreen',
        routes: {
          '/': (context) => const homepage(),
          'SplashScreen': (context) => const SplashScreen(),
          'homescreen': (context) => const homescreen(),
          'detailscreen': (context) => const detailscreen()
        },
      ),
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
    );
  }
}

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (Provider.of<ThemeProvider>(context).isDarkView)
            ? Colors.white
            : Colors.black,
        title: Text(
          "Solar System",
          style: TextStyle(
            color: (Provider.of<ThemeProvider>(context).isDarkView)
                ? Colors.black
                : Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: 770,
            width: double.infinity,
            color: (Provider.of<ThemeProvider>(context).isDarkView)
                ? Colors.white
                : Colors.black,
            child: (Provider.of<ThemeProvider>(context).isDarkView)
                ? Image.asset(
                    'assets/Bglight.jpg',
                    fit: BoxFit.fill,
                  )
                : Image.asset(
                    "assets/Bg.png",
                    fit: BoxFit.fill,
                  ),
          ),
          Align(
            alignment: Alignment(0, 0.7),
            child: Theme(
              data: ThemeData(useMaterial3: true),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    (Provider.of<ThemeProvider>(context).isDarkView)
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('homescreen');
                },
                child: Text(
                  "Let's Go...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: (Provider.of<ThemeProvider>(context).isDarkView)
                        ? Colors.black
                        : Colors.white,
                    fontSize: h * 0.02,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: (Provider.of<ThemeProvider>(context).isDarkView)
          ? Colors.black
          : Colors.white,
    );
  }
}
