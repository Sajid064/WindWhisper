import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'home.dart';

class MySplash extends StatefulWidget {
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.gif(
      gifPath: 'images/hummingbird.gif',
      gifWidth: 200,
      gifHeight: 350,
      backgroundColor: Colors.white,
      nextScreen: const Home(),
      duration: const Duration(milliseconds: 4000),
      onInit: () async {
        debugPrint("onInit");
      },
      onEnd: () async {
        debugPrint("onEnd 1");
      },
    );
  }
}
