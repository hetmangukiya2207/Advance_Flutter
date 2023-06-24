import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:media_player_app/controllers/providers/video_provider.dart';
import 'package:media_player_app/utils/video_details.dart';
import 'package:provider/provider.dart';

class VideoControlsPage extends StatefulWidget {
  const VideoControlsPage({Key? key}) : super(key: key);

  @override
  State<VideoControlsPage> createState() => _VideoControlsPageState();
}

class _VideoControlsPageState extends State<VideoControlsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<VideoProvider>(context, listen: false).videoInitialization();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Chewie(
                      controller: Provider.of<VideoProvider>(context)
                          .videoModel
                          .chewieController!,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    videoDetails[videoIndex]['title'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ...videoDetails.map(
                      (e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  e['thumbnail'],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            e['title'],
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    Provider.of<VideoProvider>(context, listen: false).videoDeactivate();
  }
}
