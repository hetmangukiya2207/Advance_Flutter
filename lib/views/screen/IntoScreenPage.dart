import 'package:flutter/material.dart';
import 'package:intro_screen_using_package/views/utils/ImageUtils.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreenPage extends StatefulWidget {
  const IntroScreenPage({Key? key}) : super(key: key);

  @override
  State<IntroScreenPage> createState() => _IntroScreenPageState();
}

class _IntroScreenPageState extends State<IntroScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            body: "Enjoy Simple, Instant & Secure Banking Anytime, Anywhere!",
            title: "Fast And Safe Banking",
            image: Image.asset(ImagePath + P1),
          ),
          PageViewModel(
            body: "Experience 200+ Banking Services Available To You 24*7",
            title: "One Place For All Your Banking Needs",
            image: Image.asset(ImagePath + P2),
          ),
          PageViewModel(
            body: "Hide Your All  Data For Your Security",
            title: "Hide You Information",
            image: Image.asset(ImagePath + P3),
          ),
          PageViewModel(
            body: "Set Pin For Your Security Otherwise Your Data Are Not Secure",
            title: "Set Your Pin",
            image: Image.asset(ImagePath + P4),
          ),
          PageViewModel(
            body: "Open A New Digital Savings Account Within A Few Minutes",
            title: "Instant Account Opening",
            image: Image.asset(ImagePath + P5),
          ),
        ],
        done: Text("Done"),
        showNextButton: false,
        onDone: () {
          Navigator.of(context).pushNamed('/');
        },
      ),
    );
  }
}
