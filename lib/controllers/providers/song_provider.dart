import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:media_player_app/models/song_model.dart';
import 'package:media_player_app/utils/song_details.dart';

class SongProvider extends ChangeNotifier {
  SongModel songModel;

  SongProvider({required this.songModel});

  autoPlaySong() {
    songModel.isSongPlay = true;
    notifyListeners();
  }

  playSong() {
    songModel.isSongPlay = !songModel.isSongPlay;
    notifyListeners();
  }

  muteSong() {
    songModel.isMute = !songModel.isMute;
    notifyListeners();
  }

  playButton() async {
    playSong();
    await songModel.assetsAudioPlayer.playOrPause();
    notifyListeners();
  }

  muteButton() async {
    muteSong();
    if (songModel.isMute) {
      songModel.volume = 0;
      await songModel.assetsAudioPlayer.setVolume(0);
      notifyListeners();
    } else {
      songModel.volume = 0.7;
      await songModel.assetsAudioPlayer.setVolume(0.7);
      notifyListeners();
    }
  }

  Widget volumeIcon() {
    if (songModel.isMute) {
      return const Icon(
        Icons.volume_off,
        size: 28,
      );
    } else if (songModel.volume <= 0.5) {
      return const Icon(
        Icons.volume_down,
        size: 28,
      );
    } else {
      return const Icon(
        Icons.volume_up,
        size: 28,
      );
    }
  }

  volumeSlider(double volume) async {
    songModel.volume = volume;
    await songModel.assetsAudioPlayer.setVolume(volume);
    if (volume == 0) {
      muteSong();
    } else if (songModel.isMute && volume > 0) {
      muteSong();
    }
    notifyListeners();
  }

  Widget playAndPauseIcon() {
    if (songModel.isSongPlay) {
      return const Icon(
        Icons.pause,
        size: 38,
      );
    } else {
      return const Icon(
        Icons.play_arrow,
        size: 38,
      );
    }
  }

  songDeactivate() async {
    songModel.isSongPlay = false;
    await songModel.assetsAudioPlayer.stop();
    notifyListeners();
  }

  currentSliderValue(AsyncSnapshot snapshot) {
    songModel.currentSliderValue =
        (snapshot.data != null) ? snapshot.data : const Duration(seconds: 0);
    notifyListeners();
  }

  totalDuration() {
    try {
      songModel.totalDuration =
          songModel.assetsAudioPlayer.current.value!.audio.duration;
      notifyListeners();
    } catch (e) {
      songModel.totalDuration = const Duration(seconds: 0);
      notifyListeners();
    }
  }

  previousSong() async {
    if (songModel.isSongPlay == false) {
      playSong();
    }
    if (songModel.currentSliderValue < const Duration(seconds: 5) &&
        songIndex > 0) {
      songIndex--;
      await songModel.assetsAudioPlayer.previous();
    } else if (songIndex > 0) {
      songIndex--;
      await songModel.assetsAudioPlayer.previous();
      await songModel.assetsAudioPlayer.previous();
    }
    notifyListeners();
  }

  nextSong() async {
    if (songModel.isSongPlay == false) {
      playSong();
    }
    if (((songDetails.length) - 1) > songIndex) {
      songIndex++;
      await songModel.assetsAudioPlayer.next();
    }
    notifyListeners();
  }

  songInitialization(int index) {
    songModel.assetsAudioPlayer.open(
      Playlist(
        startIndex: index,
        audios: [
          ...songDetails.map(
            (e) => Audio(e['audio']),
          ),
        ],
      ),
      autoStart: songModel.isSongPlay,
      loopMode: LoopMode.single,
    );
    notifyListeners();
  }
}
