import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/CounterProvider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter App"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "${Provider.of<CounterProvider>(context, listen: true).counter.cnt}",
          style: TextStyle(fontSize: 40),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<CounterProvider>(context, listen: false).increseCounter();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}