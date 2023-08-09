import 'package:budget_tracker_app/views/components/helper/Helper.dart';
import 'package:budget_tracker_app/views/screens/page1.dart';
import 'package:budget_tracker_app/views/screens/page2.dart';
import 'package:budget_tracker_app/views/screens/page3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController pageController;

  List<Widget> allPages = [
    const Page1(),
    const Page2(),
    const Page3(),
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: selectedIndex, keepPage: true);
    DbHelper.dbHelper.initDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: allPages,
        onPageChanged: (val) {
          setState(() {
            selectedIndex = val;
          });
        },
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (val) {
          setState(
            () {
              selectedIndex = val;
              pageController.animateToPage(selectedIndex,
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.linear);
            },
          );
        },
        destinations: const [
          NavigationDestination(icon: Icon(CupertinoIcons.add), label: "Add"),
          NavigationDestination(icon: Icon(CupertinoIcons.alt), label: "Data"),
          NavigationDestination(
              icon: Icon(CupertinoIcons.money_dollar), label: "Spend"),
        ],
      ),
    );
  }
}
