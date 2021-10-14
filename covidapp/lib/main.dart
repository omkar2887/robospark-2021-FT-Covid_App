// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// We will convert this splash widget to statefull further.
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Splash Screen here");
  }
}
