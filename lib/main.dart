import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_app/binding/bindings.dart';
import 'package:music_app/screen/home_screen.dart';
import 'package:music_app/screen/player_screen.dart';
import 'package:music_app/screen/splash_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await JustAudioBackground.init(
  //
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/splash",
      getPages: [
        GetPage(
            name: HomeScreen.routeNamed,
            page: () => const HomeScreen(),
            binding: HomeBinding(),
        ),
        GetPage(
          name: SplashScreen.routeNamed,
          page: () => const SplashScreen(),
          binding: HomeBinding(),
        ),
      ],
    );
  }
}
