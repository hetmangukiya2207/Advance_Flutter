import 'package:flutter/cupertino.dart';
import 'package:platform_convert_app/provider/GlobalProvider.dart';
import 'package:provider/provider.dart';

import '../components/CupertinoApp/CupertinoAddPeoplePage.dart';
import '../components/CupertinoApp/CupertinoCallsPage.dart';
import '../components/CupertinoApp/CupertinoChatsPage.dart';
import '../components/CupertinoApp/CupertinoSettingsPage.dart';
import '../components/MaterialApp/MaterialAddPeoplePage.dart';


class CupertinoAppPage extends StatefulWidget {
  const CupertinoAppPage({Key? key}) : super(key: key);

  @override
  State<CupertinoAppPage> createState() => _CupertinoAppPageState();
}

class _CupertinoAppPageState extends State<CupertinoAppPage> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Platform Converter"),
        trailing: CupertinoSwitch(
          value: Provider.of<GlobalProvider>(context).IsIos,
          onChanged: (val) {
            Provider.of<GlobalProvider>(context, listen: false)
                .SwitchBtn(val);
          },
        ),
      ),
      child: SafeArea(
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.group),
                label: "Add People",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble),
                label: "Chats",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.phone),
                label: "Calls",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
                label: "Settings",
              ),
            ],
            currentIndex: Provider.of<GlobalProvider>(context).index,
            onTap: (val) {
              Provider.of<GlobalProvider>(context, listen: false).CurIndex(val);
            },
          ),
          tabBuilder: (BuildContext context, int index) {
            late Widget page;
            switch (index) {
              case 0:
                page = const CupertinoAddPeoplePage();
                break;
              case 1:
                page = const CupertinoChatsPage();
                break;
              case 2:
                page = CupertinoCallsPage();
                break;
              case 3:
                page = const CupertinoSettingsPage();
                break;
            }
            return CupertinoTabView(builder: (BuildContext context) {
              return page;
            });
          },
        ),
      ),
    );
  }
}
