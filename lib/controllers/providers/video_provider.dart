import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:media_player_app/models/video_model.dart';
import 'package:media_player_app/utils/video_details.dart';
import 'package:video_player/video_player.dart';

class VideoProvider extends ChangeNotifier {
  VideoModel videoModel;

  VideoProvider({required this.videoModel});

  videoInitialization() {
    videoModel.videoPlayerController =
        VideoPlayerController.asset(videoDetails[videoIndex]['video'])
          ..initialize();
    notifyListeners();

    videoModel.chewieController = ChewieController(
      videoPlayerController: videoModel.videoPlayerController!,
      autoPlay: false,
      fullScreenByDefault: true,
      allowFullScreen: true,
    );
    notifyListeners();
  }

  videoDeactivate() async {
    await videoModel.videoPlayerController!.pause();
    await videoModel.chewieController!.pause();
    notifyListeners();
  }
}
