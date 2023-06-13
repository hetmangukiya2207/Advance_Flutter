import 'package:flutter/material.dart';
import 'package:ott_app_platform_app/views/utils/ListUtils.dart';

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
        title: Text(
          "OTT Platform App",
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.vertical_distribute_rounded),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
            ),
          ),
          SizedBox(
            width: w * 0.02,
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(h * 0.02),
        itemCount: OTTList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          mainAxisSpacing: 8.0, // Spacing between rows
          crossAxisSpacing: 8.0, // Spacing between columns
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('OTTPlatformScreen',arguments: OTTList[index] );
            },
            child: Container(
              color: Colors.blue,
              child: Image(
                image: NetworkImage(
                  OTTList[index]['Logo'],
                ),
                // Convert URL to ImageProvider
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
