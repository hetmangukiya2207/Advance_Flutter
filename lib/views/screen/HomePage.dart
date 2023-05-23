import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Intro Screen"),
        centerTitle: true,
        actions: [
          SizedBox(
            width: w * 0.02,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.vertical_distribute_sharp),
        ),
      ),
      body: Center(
        child: Column(),
      ),
    );
  }
}
