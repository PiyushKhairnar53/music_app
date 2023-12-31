import 'package:get/get.dart';
import 'package:music_app/controller/music_controller.dart';

class HomeBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<MusicController>(() => MusicController());
  }
}