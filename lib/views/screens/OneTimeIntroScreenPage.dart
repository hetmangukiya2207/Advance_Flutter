import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OneTimeIntroScreenPage extends StatelessWidget {
  final List<PageViewModel> pages = [
    PageViewModel(
      title: "Welcome to Weather App",
      body: "Get accurate weather information for your location.",
      image: Image.asset('assets/images/weather.png'),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    PageViewModel(
      title: "Real-Time Weather Updates",
      body: "Stay up-to-date with the latest weather conditions.",
      image: Image.asset('assets/images/weather_updates.png'),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    PageViewModel(
      title: "Weather Forecasts",
      body: "Get detailed forecasts for the upcoming days.",
      image: Image.asset('assets/images/weather_forecast.png'),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ];

  OneTimeIntroScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: const Color(0xff0587fc),
      pages: pages,
      onDone: () {
        Navigator.of(context).pushReplacementNamed('/');
      },
      showSkipButton: true,
      skip: const Text('Skip'),
      done: const Text('Done'),
      next: const Icon(Icons.arrow_forward),
      dotsDecorator: const DotsDecorator(
        activeSize: Size(10.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
