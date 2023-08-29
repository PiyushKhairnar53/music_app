import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../controller/music_controller.dart';

class PlayerScreen extends StatelessWidget {
  static const routeNamed = '/player_screen';

  final SongModel song;

  const PlayerScreen({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    MusicController musicController = Get.find();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.grey[900],
            image: DecorationImage(
              image: AssetImage(musicController
                  .coverImageList[musicController.randomNumber.value]),
              fit: BoxFit.cover,
              opacity: 0.5,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      const SizedBox(
                        width: 35,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(
                            () => Text(
                          musicController
                              .songs[musicController.currentIndex.value].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                )
              ],
            ),
            Column(
              children: [
                Obx(() => Slider(
                    value: musicController.currentValue.value
                        .clamp(0.0, musicController.max.value),
                    min: 0.0,
                    max: musicController.max.value,
                    onChanged: (seconds) {
                      musicController.changeDurationToSecond(seconds.toInt());
                      seconds = seconds;
                    })),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Duration",
                        // RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                        //     .firstMatch("$_remaining")
                        //     ?.group(1) ??
                        //     '$_remaining',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        musicController.onBackPlay();
                      },
                      icon: const Icon(Icons.skip_previous_rounded,
                          color: Colors.white, size: 30),
                    ),
                    Obx(() => InkWell(
                          onTap: () {
                            musicController.playPause();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: musicController.isPlaying.value
                                ? const Icon(
                                    Icons.pause_rounded,
                                    size: 50,
                                    color: Colors.black,
                                  )
                                : const Icon(
                                    Icons.play_arrow_rounded,
                                    size: 50,
                                    color: Colors.black,
                                  ),
                          ),
                        )),
                    IconButton(
                        icon: const Icon(Icons.skip_next_rounded,
                            color: Colors.white, size: 30),
                        onPressed: () {
                          musicController.nextPlay();
                        }),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
// Duration get _remaining => widget.duration! - widget.position!;
}
