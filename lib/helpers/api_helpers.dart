import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pr7_1_dbminer/modal.dart';

class QuotesAPIHelper {
  QuotesAPIHelper._();

  static final QuotesAPIHelper quotesAPIHelper = QuotesAPIHelper._();

  String url = 'https://api.quotable.io/quotes';

  Future<QuotesAPI?> fetchRandomQuote() async {
    http.Response res =
        await http.get(Uri.parse("https://api.quotable.io/random"));

    if (res.statusCode == 200) {
      Map<String, dynamic> decodedData = jsonDecode(res.body);

      QuotesAPI randomQuote = QuotesAPI.fromJSON(decodedData,
          "https://source.unsplash.com/random/1?background,nature,dark");

      return randomQuote;
    }
    return null;
  }

  Future<List<QuotesAPI>?> fetchLatestQuotes() async {
    String url = "https://api.quotable.io/quotes";

    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(res.body);
      List decodedData = data["results"];
      List<String> imageList = [];

      for (int i = 0; i < decodedData.length; i++) {
        imageList.add(
            "https://source.unsplash.com/random/${i + 1}?background,nature,dark");
      }

      List<QuotesAPI> latestQuotes = decodedData
          .map((e) => QuotesAPI.fromJSON(e, imageList[decodedData.indexOf(e)]))
          .toList();

      return latestQuotes;
    }
    return null;
  }

  Future<List<QuotesAPI>?> fetchQuotes(
      {required bool isAuthCat, required String name}) async {
    String url = (isAuthCat)
        ? 'https://api.quotable.io/quotes/?author=$name'
        : 'https://api.quotable.io/quotes/?tags=$name';

    http.Response res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(res.body);
      List decodedData = data["results"];
      List<String> imageList = [];

      for (int i = 0; i < decodedData.length; i++) {
        imageList.add(
            "https://source.unsplash.com/random/${i + 1}?background,$name,dark");
      }

      List<QuotesAPI> quotesList = decodedData
          .map((e) => QuotesAPI.fromJSON(e, imageList[decodedData.indexOf(e)]))
          .toList();

      return quotesList;
    }
    return null;
  }
}
