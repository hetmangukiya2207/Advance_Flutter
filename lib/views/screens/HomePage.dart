import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/ConnectionProvider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    Provider.of<ConnectionProvider>(context, listen: false)
        .checkInternetConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (Provider.of<ConnectionProvider>(context)
                  .connectivityModel
                  .connectivityStatus ==
              "waiting")
          ? AppBar(
              title: Text(
                "Smart Weather App",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            )
          : AppBar(
              title: Text(
                "Smart Weather App",
                style: TextStyle(),
              ),
              centerTitle: true,
            ),
    );
  }
}
