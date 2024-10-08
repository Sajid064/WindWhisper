import 'package:flutter/material.dart';
import 'splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WindWhisper',
      home: const MySplash(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: const Color(0xFF0b111e),
        appBarTheme: const AppBarTheme(
          backgroundColor:
              Color(0xFF0b111e), // Set the app bar background color
        ),
        scaffoldBackgroundColor: const Color(0xFF0b111e),
      ),
    );
  }
}
