import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import '../../Provider/ConnectionProvider.dart';
import '../utils/ListUtils.dart';

class GooglePage extends StatefulWidget {
  const GooglePage({super.key});

  @override
  State<GooglePage> createState() => _GooglePageState();
}

class _GooglePageState extends State<GooglePage> {
  InAppWebViewController? inAppWebViewController;

  String? group;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Browser"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        Future.delayed(
                            Duration(seconds: 0),
                            () => showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    child: ListView.builder(
                                        itemCount: BookMarkList.length,
                                        itemBuilder: (context, index) =>
                                            ListTile(
                                              title: Text(
                                                  "${BookMarkList[index]['Name']}"),
                                              subtitle: Text(
                                                  "${BookMarkList[index]['Url']}"),
                                            )),
                                  );
                                }));
                      },
                      value: 1,
                      child: Row(
                        children: [
                          Icon(Icons.bookmark),
                          SizedBox(width: 20),
                          Text("All Bookmarks")
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        Future.delayed(
                          Duration(seconds: 0),
                          () => showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Search Engine"),
                              alignment: Alignment.center,
                              content: Container(
                                height: 200,
                                width: 400,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Radio(
                                            value: "g",
                                            groupValue:
                                                Provider.of<ConnectionProvider>(
                                                        context)
                                                    .radio,
                                            onChanged: (val) {
                                              Provider.of<ConnectionProvider>(
                                                      context,
                                                      listen: false)
                                                  .ChangeRadio(val!);
                                              Navigator.of(context).pop;
                                            }),
                                        SizedBox(width: 20),
                                        Text(
                                          "Google",
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                'YahooPage', (route) => false);
                                      },
                                      child: Row(
                                        children: [
                                          Radio(
                                              value: "a",
                                              groupValue:
                                                  Provider.of<ConnectionProvider>(
                                                          context)
                                                      .radio,
                                              onChanged: (val) {
                                                Provider.of<ConnectionProvider>(
                                                        context,
                                                        listen: false)
                                                    .ChangeRadio(val!);
                                                Navigator.of(context)
                                                    .pushNamedAndRemoveUntil(
                                                        'YahooPage',
                                                        (route) => false);
                                                Navigator.of(context).pop;
                                              }),
                                          SizedBox(width: 20),
                                          Text(
                                            "Yahoo",
                                            style: TextStyle(fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                            value: "f",
                                            groupValue:
                                                Provider.of<ConnectionProvider>(
                                                        context)
                                                    .radio,
                                            onChanged: (val) {
                                              Provider.of<ConnectionProvider>(
                                                      context,
                                                      listen: false)
                                                  .ChangeRadio(val!);
                                              Navigator.of(context).pushNamedAndRemoveUntil('BingPage', (route) => false);
                                              Navigator.of(context).pop;
                                            }),
                                        SizedBox(width: 20),
                                        Text(
                                          "Bing",
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio(
                                            value: "o",
                                            groupValue:
                                                Provider.of<ConnectionProvider>(
                                                        context)
                                                    .radio,
                                            onChanged: (val) {
                                              Provider.of<ConnectionProvider>(
                                                      context,
                                                      listen: false)
                                                  .ChangeRadio(val!);
                                              Navigator.of(context).pushNamedAndRemoveUntil('DuckDuckPage', (route) => false);
                                              Navigator.of(context).pop;
                                            }),
                                        SizedBox(width: 20),
                                        Text(
                                          "Duck Duck Go",
                                          style: TextStyle(fontSize: 16),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Icon(Icons.screen_search_desktop_outlined),
                          SizedBox(width: 20),
                          Text("Search Engine")
                        ],
                      ),
                    ),
                  ])
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () async {
                await inAppWebViewController?.loadUrl(
                    urlRequest: URLRequest(
                        url: Uri.parse("https://in.search.yahoo.com/")));
              },
              icon: Icon(Icons.home)),
          IconButton(
              onPressed: () async {
                Map<String, dynamic> item = {
                  "Name": "Google",
                  "Url": "https://www.google.com/",
                };

                BookMarkList.add(item);
              },
              icon: Icon(Icons.bookmark_add)),
          IconButton(
              onPressed: () async {
                if (await inAppWebViewController!.canGoBack()) {
                  inAppWebViewController?.goBack();
                }
              },
              icon: Icon(Icons.arrow_back_ios_new)),
          IconButton(
              onPressed: () async {
                await inAppWebViewController?.reload();
              },
              icon: Icon(Icons.refresh)),
          IconButton(
              onPressed: () async {
                if (await inAppWebViewController!.canGoForward()) {
                  inAppWebViewController?.goForward();
                }
              },
              icon: Icon(Icons.arrow_forward_ios)),
        ],
      ),
      body: StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) =>
            (snapshot.data == ConnectivityResult.wifi ||
                    snapshot.data == ConnectivityResult.mobile)
                ? Center(
                    child: InAppWebView(
                      initialUrlRequest: URLRequest(
                        url: Uri.parse("https://www.google.com/"),
                      ),
                      onLoadStart: (controller, uri) {
                        setState(() {
                          inAppWebViewController = controller;
                        });
                      },
                      onLoadStop: (controller, uri) {},
                    ),
                  )
                : Center(
                    child: Column(
                      children: [
                        Container(
                          child: Image(
                            image: AssetImage("assets/dog.jpeg"),
                          ),
                        ),
                        Container(
                          child: Image(
                            image: AssetImage("assets/1.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
