import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class UrlModel {
  String url;
  String? urlBookmark;

  int? selectedOption = 0;

  List<String> bookmarkPageName;
  List<String> bookmarkPageUrl;

  TextEditingController searchController;
  InAppWebViewController? inAppWebViewController;
  PullToRefreshController? pullToRefreshController;

  UrlModel({
    required this.url,
    this.inAppWebViewController,
    required this.searchController,
    this.pullToRefreshController,
    this.urlBookmark,
    this.selectedOption,
    required this.bookmarkPageName,
    required this.bookmarkPageUrl,
  });
}
