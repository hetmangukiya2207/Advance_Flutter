import 'package:flutter/material.dart';
import 'package:media_player_app/controllers/providers/video_provider.dart';
import 'package:media_player_app/models/video_model.dart';
import 'package:media_player_app/views/components/AudioControlsPage.dart';
import 'package:media_player_app/views/components/VideoControlsPage.dart';
import 'package:provider/provider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:media_player_app/controllers/providers/song_provider.dart';
import 'package:media_player_app/models/song_model.dart';
import 'package:media_player_app/views/screens/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SongProvider(
            songModel: SongModel(
              isSongPlay: false,
              isMute: false,
              volume: 0.6,
              assetsAudioPlayer: AssetsAudioPlayer(),
              currentSliderValue: const Duration(seconds: 0),
              totalDuration: const Duration(seconds: 0),
              songIndex: 0,
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => VideoProvider(
            videoModel: VideoModel(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        routes: {
          '/': (context) => const HomePage(),
          'AudioControlsPage': (context) => const AudioControlsPage(),
          'VideoControlsPage': (context) => const VideoControlsPage(),
        },
      ),
    ),
  );
}
