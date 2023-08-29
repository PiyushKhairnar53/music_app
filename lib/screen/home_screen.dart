import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/controller/music_controller.dart';
import 'package:music_app/screen/player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatelessWidget {
  static const routeNamed = '/';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MusicController musicController = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Music App",style: TextStyle(color: Colors.white),),
        leading: const Icon(Icons.music_note,color: Colors.white,),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FutureBuilder<List<SongModel>>(
                future: musicController.audioQuery.querySongs(
                  ignoreCase: true,
                  orderType: OrderType.ASC_OR_SMALLER,
                  sortType: null,
                  uriType: UriType.EXTERNAL,
                ),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('No songs found'),
                    );
                  }

                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            musicController.songPlay(
                                snapshot.data![index].data, index);
                            // musicController.songs.insert(0, snapshot.data![index]);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5.0),
                            child: ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.music_note,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(snapshot.data![index].title,
                                  maxLines: 2,
                                  style: const TextStyle(color: Colors.black)),
                              trailing: const Icon(Icons.play_arrow,
                                  color: Colors.black),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => InkWell(
          onTap: () {
            Get.to(() => PlayerScreen(song: musicController.songs[0]));
          },
          child: SizedBox(
              child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 250,
                  child: Text(
                    musicController
                        .songs[musicController.currentIndex.value].title,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
                Obx(
                  () => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    width: 50,
                    height: 50,
                    child: IconButton(
                        onPressed: () {
                          musicController.playPause();
                        },
                        icon: musicController.isPlaying.value
                            ? const Icon(
                                Icons.pause_rounded,
                                color: Colors.black,
                              )
                            : const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.black,
                              )
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
