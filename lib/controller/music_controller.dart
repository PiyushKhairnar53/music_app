import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:just_audio/just_audio.dart';

class MusicController extends GetxController{
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  RxBool isPlaying = false.obs;
  RxBool isLooping = false.obs;
  RxInt currentIndex = 0.obs;
  var duration = ''.obs;
  var position = ''.obs;
  var max = 0.0.obs;
  var currentValue = 0.0.obs;
  RxInt randomNumber = 0.obs;
  RxList<SongModel> songs = <SongModel>[].obs;
  RxList<SongModel> allSongs = <SongModel>[].obs;
  List coverImageList = [
    "assets/bg/bg.jpg",
    "assets/bg/bg1.jpg",
    "assets/bg/bg2.jpg",
    "assets/bg/bg3.jpg",
    "assets/bg/bg4.jpg",
    "assets/bg/bg5.jpg",
    "assets/bg/bg6.jpg",
    "assets/bg/bg7.jpg"
  ];

  @override
  void onInit(){
    super.onInit();
    checkStoragePermission(retry: true);
    // allSongs = audioQuery.querySongs() as RxList<SongModel>;
    songList();

  }

  playPause(){
    if(!isPlaying.value){
      audioPlayer.play();
    }else{
      audioPlayer.pause();
    }
    isPlaying.value = !isPlaying.value;
  }

  nextPlay(){
    // audioPlayer.seekToNext();
    // songs.insert(audioPlayer.nextIndex!, songs[audioPlayer.nextIndex!].data as SongModel);
    // print("Songs data 0- ${songs[0].data}");
    // print("Next Song index - ${audioPlayer.nextIndex!}");

    // print("Songs data 1- ${songs[1].data}");
    // print("Songs data 2- ${songs[1].data}");
    // print("Songs data 1- ${songs[1].data}");
    if(currentIndex.value >= songs.length-1){
      songPlay(songs[0].data, 0);
    }else {
      songPlay(songs[currentIndex.value + 1].data, currentIndex.value + 1);
    }
  }

  onBackPlay(){
    // audioPlayer.seekToPrevious();
    if(currentIndex.value-1 == -1) {
      songPlay(songs[songs.length-1].data, songs.length-1);
    }
    else {
      songPlay(songs[currentIndex.value - 1].data, currentIndex.value - 1);
    }
  }

  void songList() async{
    Future <List<SongModel>> as = audioQuery.querySongs();
    int count = 0;
    for(SongModel song in await as){
      songs.add(song);
    }
    for(SongModel song in songs){
      count++;
      print("Song $count title - ${song.title}");
    }
  }

  void songPlay(String uri,int index){

    print('Duration - ${currentValue.value}');

    currentIndex.value = index;
    try{
      audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri),
          tag: MediaItem(
            id:index.toString(),
            title:songs[index].title
          )
        )
      );
      updatePosition();
      audioPlayer.play();
      isPlaying.value = true;
      // getRandomNumber();
    }catch(ex){
      print(ex);
    }
  }

  updatePosition() async{
    try{
      audioPlayer.durationStream.listen((event) {
        if(event != null){
          duration.value = event.toString().split(".")[0];
          max.value = event.inSeconds.toDouble();
        }
      });

      audioPlayer.positionStream.listen((pos) {
        duration.value = pos.toString().split(".")[0];
        currentValue.value = pos.inSeconds.toDouble();
      });
    }catch(ex){
      print(ex);
    }
  }

  // void getRandomNumber(){
  //   randomNumber.value = Random().nextInt(7);
  // }

  changeDurationToSecond(seconds){
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  checkStoragePermission({bool retry = false}) async{
    try{
      await audioQuery.checkAndRequest(retryRequest: retry);
    }catch(ex){
      print(ex);
    }
  }

}