import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
  static const routeNamed = '/splash';

}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
    ()=>Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder:(
                context
                ) => const HomeScreen()
        ))
    );
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
               Icons.music_note,
                color: Colors.white,
                size: 50.0,
              ),
              Text('Music App',style: TextStyle(color: Colors.white),)
            ],
          )
      ),
    );
  }
}