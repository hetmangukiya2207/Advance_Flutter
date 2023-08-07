import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:search_engine/controllers/providers/connectivity_provider.dart';
import 'package:search_engine/controllers/providers/url_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false)
        .checkInternetConnectivity();

    Provider.of<UrlProvider>(context, listen: false).refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Browser",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w400,
            ),
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton(
              constraints: const BoxConstraints.expand(height: 110, width: 250),
              offset: const Offset(10, 50),
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.bookmark_add_outlined),
                      SizedBox(
                        width: 25,
                      ),
                      Text("All BookMarks"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.laptop),
                      SizedBox(
                        width: 25,
                      ),
                      Text("Search Engine"),
                    ],
                  ),
                ),
              ],
              onSelected: (selectedOption) {
                Provider.of<UrlProvider>(context, listen: false)
                    .urlModel
                    .selectedOption = selectedOption;
                if (selectedOption == 1) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                    ),
                                    label: const Text(
                                      "Dismiss",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: (Provider.of<UrlProvider>(context,
                                          listen: false)
                                      .urlModel
                                      .bookmarkPageName
                                      .isNotEmpty)
                                  ? ListView.builder(
                                      itemCount:
                                          Provider.of<UrlProvider>(context)
                                              .urlModel
                                              .bookmarkPageName
                                              .length,
                                      itemBuilder: (context, i) => ListTile(
                                        onTap: () {
                                          Provider.of<UrlProvider>(context,
                                                  listen: false)
                                              .loadUrl(i);
                                          Navigator.of(context).pop();
                                        },
                                        title: Text(Provider.of<UrlProvider>(
                                                context,
                                                listen: false)
                                            .urlModel
                                            .bookmarkPageName[i]),
                                        subtitle: Text(Provider.of<UrlProvider>(
                                                context,
                                                listen: false)
                                            .urlModel
                                            .bookmarkPageUrl[i]),
                                        trailing: IconButton(
                                          onPressed: () {
                                            Provider.of<UrlProvider>(context,
                                                    listen: false)
                                                .removeBookmark(i);
                                          },
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: Text("No any bookmarks yet..."),
                                    ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (selectedOption == 2) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Search Engine",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RadioListTile(
                            title: const Text("Google"),
                            value: "https://www.google.com/",
                            groupValue:
                                Provider.of<UrlProvider>(context).urlModel.url,
                            onChanged: (url) {
                              Provider.of<UrlProvider>(context, listen: false)
                                  .urlModel
                                  .url = url!;

                              Provider.of<UrlProvider>(context, listen: false)
                                  .launchBrowser();
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                            title: const Text("Yahoo"),
                            value: "https://www.yahoo.com/",
                            groupValue:
                                Provider.of<UrlProvider>(context).urlModel.url,
                            onChanged: (url) {
                              Provider.of<UrlProvider>(context, listen: false)
                                  .urlModel
                                  .url = url!;

                              Provider.of<UrlProvider>(context, listen: false)
                                  .launchBrowser();
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                            title: const Text("Bing"),
                            value: "https://www.bing.com/",
                            groupValue:
                                Provider.of<UrlProvider>(context).urlModel.url,
                            onChanged: (url) {
                              Provider.of<UrlProvider>(context, listen: false)
                                  .urlModel
                                  .url = url!;

                              Provider.of<UrlProvider>(context, listen: false)
                                  .launchBrowser();
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                            title: const Text("Duck Duck Go"),
                            value: "https://duckduckgo.com/",
                            groupValue:
                                Provider.of<UrlProvider>(context).urlModel.url,
                            onChanged: (url) {
                              Provider.of<UrlProvider>(context, listen: false)
                                  .urlModel
                                  .url = url!;

                              Provider.of<UrlProvider>(context, listen: false)
                                  .launchBrowser();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        body: (Provider.of<ConnectivityProvider>(context)
                    .connectivityModel
                    .connectivityStatus ==
                "waiting")
            ? const Center(
                child: Text(
                  "Offline",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    flex: 25,
                    child: InAppWebView(
                      pullToRefreshController: Provider.of<UrlProvider>(context)
                          .urlModel
                          .pullToRefreshController,
                      onWebViewCreated: (controller) {
                        Provider.of<UrlProvider>(context, listen: false)
                            .urlModel
                            .inAppWebViewController = controller;
                      },
                      onLoadStart: (controller, url) {
                        Provider.of<UrlProvider>(context, listen: false)
                            .urlModel
                            .inAppWebViewController = controller;
                        Provider.of<UrlProvider>(context, listen: false)
                            .urlModel
                            .urlBookmark = url.toString();
                      },
                      onLoadStop: (controller, url) async {
                        await Provider.of<UrlProvider>(context, listen: false)
                            .urlModel
                            .pullToRefreshController
                            ?.endRefreshing();
                      },
                      initialUrlRequest: URLRequest(
                        url: Uri.parse(
                            Provider.of<UrlProvider>(context).urlModel.url),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            TextField(
                              controller: Provider.of<UrlProvider>(context)
                                  .urlModel
                                  .searchController,
                              decoration: InputDecoration(
                                hintText: "Search or type web address",
                                border: const OutlineInputBorder(),
                                suffixIcon: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Provider.of<UrlProvider>(context,
                                                listen: false)
                                            .search();
                                      },
                                      icon: const Icon(Icons.search),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Provider.of<UrlProvider>(context,
                                                listen: false)
                                            .clearSearchValue();
                                      },
                                      icon: const Icon(Icons.clear),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Provider.of<UrlProvider>(context,
                                            listen: false)
                                        .goHome();
                                  },
                                  icon: const Icon(Icons.home_outlined),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Provider.of<UrlProvider>(context,
                                            listen: false)
                                        .addBookmark();
                                  },
                                  icon: const Icon(Icons.bookmark_add_outlined),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Provider.of<UrlProvider>(context,
                                            listen: false)
                                        .goBack();
                                  },
                                  icon: const Icon(Icons.arrow_back_ios),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Provider.of<UrlProvider>(context,
                                            listen: false)
                                        .reload();
                                  },
                                  icon: const Icon(Icons.refresh),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Provider.of<UrlProvider>(context,
                                            listen: false)
                                        .goForward();
                                  },
                                  icon: const Icon(Icons.arrow_forward_ios),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
