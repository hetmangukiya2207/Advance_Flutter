import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoModel {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  VideoModel({
    this.videoPlayerController,
    this.chewieController,
  });
}
