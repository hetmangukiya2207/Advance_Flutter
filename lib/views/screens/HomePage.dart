import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String joke = '';

  void fetchJoke() async {
    final response =
        await http.get(Uri.parse('https://api.chucknorris.io/jokes/random'));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final jokeText = jsonResponse['value'];
      final dateTime = DateTime.now();
      final formattedDateTime =
          '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';

      setState(() {
        joke = jokeText;
      });

      // TODO: Store the joke and formattedDateTime in your preferred storage method
      // Here, you can save it to a local database or file.

      print('Joke: $joke');
      print('Stored at: $formattedDateTime');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chuck Norris Jokes'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(
            h * 0.02,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (index == 0)
                  ? Column(
                      children: [
                        Text(
                          joke,
                          style: TextStyle(
                            fontSize: h * 0.02,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(
                height: h * 0.025,
              ),
              ElevatedButton(
                onPressed: () {
                  index == 1;
                  fetchJoke();
                },
                child: const Text('Fetch My Laugh'),
              ),
              SizedBox(
                height: h * 0.05,
              ),
              Row(
                children: [
                  FloatingActionButton(
                    heroTag: true,
                    onPressed: () async {
                      Share.share(joke);
                    },
                    child: Icon(Icons.share_rounded),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    heroTag: true,
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: joke),
                      );
                      Fluttertoast.showToast(
                        msg: 'Text copied to clipboard',
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    },
                    child: Icon(Icons.copy),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    heroTag: true,
                    onPressed: () async {
                      final Uri params = Uri(
                        scheme: 'mailto',
                        queryParameters: {
                          'subject': 'Sent from HR Mangukiya',
                          'body': joke
                        },
                      );

                      if (await canLaunch(params.toString())) {
                        await launch(params.toString());
                      } else {
                        throw 'Could not launch email';
                      }
                    },
                    child: Icon(
                      Icons.email,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
