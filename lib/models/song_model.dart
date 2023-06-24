import 'package:assets_audio_player/assets_audio_player.dart';

class SongModel {
  bool isSongPlay;
  bool isMute;
  double volume;
  AssetsAudioPlayer assetsAudioPlayer;
  Duration totalDuration;
  Duration currentSliderValue;
  int songIndex;

  SongModel({
    required this.isSongPlay,
    required this.isMute,
    required this.volume,
    required this.assetsAudioPlayer,
    required this.totalDuration,
    required this.currentSliderValue,
    required this.songIndex,
  });
}
