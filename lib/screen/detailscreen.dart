import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providder/ThemeProvider.dart';

class detailscreen extends StatefulWidget {
  const detailscreen({super.key});

  @override
  State<detailscreen> createState() => _detailscreenState();
}

class _detailscreenState extends State<detailscreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat();

  final Tween<double> turnsTween = Tween<double>(
    begin: 1,
    end: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: (Provider.of<ThemeProvider>(context).isDarkView)
                ? Colors.black
                : Colors.white,
          ),
        ),
        backgroundColor: (Provider.of<ThemeProvider>(context).isDarkView)
            ? Colors.white
            : Colors.black,
        centerTitle: true,
        title: Text(
          "Detail of Plantes",
          style: TextStyle(
            color: (Provider.of<ThemeProvider>(context).isDarkView)
                ? Colors.black
                : Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: (Provider.of<ThemeProvider>(context).isDarkView)
                ? Image.asset(
                    'assets/light.jpg',
                    fit: BoxFit.fill,
                  )
                : Image.asset(
                    "assets/2.jpg",
                    fit: BoxFit.fill,
                  ),
          ),
          Container(
            // padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: RotationTransition(
                        turns: turnsTween.animate(_controller),
                        child: Image.asset('${data.image}')),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: -2,
                          blurRadius: 10,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          "${data.name}",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color:
                                (Provider.of<ThemeProvider>(context).isDarkView)
                                    ? Colors.black
                                    : Colors.white,
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: -2,
                          blurRadius: 10,
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Text(
                      "${data.info}",
                      style: TextStyle(
                          fontSize: 22,
                          color:
                              (Provider.of<ThemeProvider>(context).isDarkView)
                                  ? Colors.black
                                  : Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
