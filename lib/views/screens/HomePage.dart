import 'package:flutter/material.dart';
import 'package:media_player_app/views/components/AudioPlayer.dart';
import 'package:media_player_app/views/components/VideoPlayer.dart';

import '../components/FilesPlayer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Media Player"),
          centerTitle: true,
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(
              fontSize: 18,
            ),
            tabs: [
              Tab(
                child: Text("Audio"),
              ),
              Tab(
                child: Text("Video"),
              ),
              Tab(
                child: Text("Files"),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AudioPlayer(),
            VideoPlayer(),
            FilesPlayer(),
          ],
        ),
      ),
    );
  }
}
