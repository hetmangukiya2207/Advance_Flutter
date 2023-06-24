import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:media_player_app/controllers/providers/song_provider.dart';
import 'package:media_player_app/utils/song_details.dart';
import 'package:provider/provider.dart';

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({Key? key}) : super(key: key);

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SongProvider>(context, listen: false)
          .songInitialization(songIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 320,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 6),
        autoPlayAnimationDuration: const Duration(seconds: 2),
        autoPlayCurve: Curves.easeInOut,
      ),
      items: [
        ...songDetails.map(
          (e) => GestureDetector(
            onTap: () {
              songIndex = songDetails.indexOf(e);
              Navigator.pushNamed(context, 'AudioControlsPage');
            },
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: AssetImage(e['poster']),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      Provider.of<SongProvider>(context, listen: false)
                          .playButton();
                    },
                    child:
                        Provider.of<SongProvider>(context).playAndPauseIcon(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    Provider.of<SongProvider>(context, listen: false).songDeactivate();
  }
}
