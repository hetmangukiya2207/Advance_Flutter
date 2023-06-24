import 'package:flutter/material.dart';
import 'package:media_player_app/controllers/providers/song_provider.dart';
import 'package:media_player_app/utils/song_details.dart';
import 'package:provider/provider.dart';

class AudioControlsPage extends StatefulWidget {
  const AudioControlsPage({Key? key}) : super(key: key);

  @override
  State<AudioControlsPage> createState() => _AudioControlsPageState();
}

class _AudioControlsPageState extends State<AudioControlsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SongProvider>(context, listen: false).autoPlaySong();
      Provider.of<SongProvider>(context, listen: false)
          .songInitialization(songIndex);
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
              flex: 1,
              child: Container(
                height: 340,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(songDetails[songIndex]['poster']),
                  ),
                ),
              ),
            ),
            SizedBox(height: 100,),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      songDetails[songIndex]['songName'],
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  StreamBuilder(
                    stream: Provider.of<SongProvider>(context)
                        .songModel
                        .assetsAudioPlayer
                        .currentPosition,
                    builder: (context, snapshot) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Provider.of<SongProvider>(context, listen: false)
                            .currentSliderValue(snapshot);
                        Provider.of<SongProvider>(context, listen: false)
                            .totalDuration();
                      });

                      return Column(
                        children: [
                          Slider(
                            min: 0,
                            max: Provider.of<SongProvider>(context,
                                    listen: false)
                                .songModel
                                .totalDuration
                                .inSeconds
                                .toDouble(),
                            value: Provider.of<SongProvider>(context)
                                .songModel
                                .currentSliderValue
                                .inSeconds
                                .toDouble(),
                            onChanged: (val) {
                              Provider.of<SongProvider>(context, listen: false)
                                  .songModel
                                  .assetsAudioPlayer
                                  .seek(
                                    Duration(seconds: val.toInt()),
                                  );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(Provider.of<SongProvider>(context)
                                    .songModel
                                    .currentSliderValue
                                    .toString()
                                    .split('.')[0]),
                                Text(Provider.of<SongProvider>(context,
                                        listen: false)
                                    .songModel
                                    .totalDuration
                                    .toString()
                                    .split('.')[0]),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          Provider.of<SongProvider>(context, listen: false)
                              .previousSong();
                        },
                        icon: const Icon(
                          Icons.skip_previous,
                          size: 34,
                        ),
                      ),
                      FloatingActionButton(
                        heroTag: null,
                        onPressed: () async {
                          Provider.of<SongProvider>(context, listen: false)
                              .playButton();
                        },
                        child: Provider.of<SongProvider>(context)
                            .playAndPauseIcon(),
                      ),
                      IconButton(
                        onPressed: () {
                          Provider.of<SongProvider>(context, listen: false)
                              .nextSong();
                        },
                        icon: const Icon(
                          Icons.skip_next,
                          size: 34,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Provider.of<SongProvider>(context, listen: false)
                              .muteButton();
                        },
                        icon: Provider.of<SongProvider>(context).volumeIcon(),
                      ),
                      Slider(
                        min: 0,
                        max: 1,
                        value:
                            Provider.of<SongProvider>(context).songModel.volume,
                        onChanged: (volume) {
                          Provider.of<SongProvider>(context, listen: false)
                              .volumeSlider(volume);
                        },
                      ),
                    ],
                  ),
                ],
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
    Provider.of<SongProvider>(context, listen: false).songDeactivate();
  }
}
