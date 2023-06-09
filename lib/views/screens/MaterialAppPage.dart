import 'package:flutter/material.dart';
import 'package:platform_convert_app/provider/GlobalProvider.dart';
import 'package:platform_convert_app/views/utils/GlobalVariable.dart';
import 'package:provider/provider.dart';

import '../../provider/ThemeProvider.dart';
import '../components/MaterialApp/MaterialAddPeoplePage.dart';
import '../components/MaterialApp/MaterialCallsPage.dart';
import '../components/MaterialApp/MaterialSettingsPage.dart';
import '../components/MaterialApp/MaterialChatsPage.dart';

class MaterialAppPage extends StatefulWidget {
  const MaterialAppPage({Key? key}) : super(key: key);

  @override
  State<MaterialAppPage> createState() => _MaterialAppPageState();
}

class _MaterialAppPageState extends State<MaterialAppPage> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Platfrom Converter"),
        actions: [
          Switch(
              value: Provider.of<GlobalProvider>(context).IsIos,
              onChanged: (val) {
                Provider.of<GlobalProvider>(context, listen: false)
                    .SwitchBtn(val);
              })
        ],
      ),
      body: PageView(
        controller: pageController,
        children: const [
          MaterialAddPeoplePage(),
          MaterialChatsPage(),
          MaterialCallsPage(),
          MaterialSettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
              color: (Provider.of<ThemeProvider>(context, listen: true).isDark)
                  ? Colors.white
                  : Colors.black,
              size: h * 0.04,
            ),
            label: "Add People",
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                color:
                    (Provider.of<ThemeProvider>(context, listen: true).isDark)
                        ? Colors.white
                        : Colors.black,
                size: h * 0.03,
              ),
              label: "Chats"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.call,
              color: (Provider.of<ThemeProvider>(context, listen: true).isDark)
                  ? Colors.white
                  : Colors.black,
              size: h * 0.03,
            ),
            label: "Calls",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: (Provider.of<ThemeProvider>(context, listen: true).isDark)
                  ? Colors.white
                  : Colors.black,
              size: h * 0.03,
            ),
            label: "Settings",
          ),
        ],
        currentIndex: Provider.of<GlobalProvider>(context).index,
        selectedItemColor:
            (Provider.of<ThemeProvider>(context, listen: true).isDark)
                ? Colors.white
                : Colors.black,
        selectedFontSize: h * 0.02,
        elevation: 5,
        onTap: (val) {
          Provider.of<GlobalProvider>(context, listen: false).CurIndex(val);
          pageController.animateToPage(val,
              duration: const Duration(milliseconds: 400),
              curve: Curves.bounceIn);
        },
      ),
    );
  }
}
