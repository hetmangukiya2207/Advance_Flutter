import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:search_engine/models/url_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UrlProvider extends ChangeNotifier {
  UrlModel urlModel;

  UrlProvider({required this.urlModel});

  launchBrowser() {
    urlModel.searchController.clear();
    urlModel.inAppWebViewController?.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse(urlModel.url),
      ),
    );
    notifyListeners();
  }

  goHome() {
    urlModel.inAppWebViewController?.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse(urlModel.url),
      ),
    );
    notifyListeners();
  }

  refreshPage() {
    urlModel.pullToRefreshController = PullToRefreshController(
      onRefresh: () async {
        await urlModel.inAppWebViewController?.reload();
        await Future.delayed(
          const Duration(seconds: 2),
        );
        urlModel.pullToRefreshController?.endRefreshing();
        notifyListeners();
      },
    );
  }

  loadUrl(int index) {
    urlModel.inAppWebViewController?.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse(urlModel.bookmarkPageUrl[index]),
      ),
    );
    notifyListeners();
  }

  search() {
    urlModel.inAppWebViewController?.loadUrl(
      urlRequest: URLRequest(
        url: Uri.parse(
            "${urlModel.url}search?q=${urlModel.searchController.text}"),
      ),
    );
    notifyListeners();
  }

  clearSearchValue() {
    urlModel.searchController.clear();
    notifyListeners();
  }

  addBookmark() async {
    urlModel.bookmarkPageName
        .add((await urlModel.inAppWebViewController?.getTitle()).toString());
    urlModel.bookmarkPageUrl.add(urlModel.urlBookmark!);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList('bookmarkPageName', urlModel.bookmarkPageName);
    prefs.setStringList('bookmarkPageUrl', urlModel.bookmarkPageUrl);
    notifyListeners();
  }

  removeBookmark(int index) async {
    urlModel.bookmarkPageName.removeAt(index);
    urlModel.bookmarkPageUrl.removeAt(index);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setStringList('bookmarkPageName', urlModel.bookmarkPageName);
    prefs.setStringList('bookmarkPageUrl', urlModel.bookmarkPageUrl);
    notifyListeners();
  }

  goBack() async {
    if (await urlModel.inAppWebViewController!.canGoBack()) {
      urlModel.inAppWebViewController?.goBack();
    }
    notifyListeners();
  }

  reload() {
    urlModel.inAppWebViewController?.reload();
    notifyListeners();
  }

  goForward() async {
    if (await urlModel.inAppWebViewController!.canGoForward()) {
      urlModel.inAppWebViewController?.goForward();
    }
    notifyListeners();
  }
}
