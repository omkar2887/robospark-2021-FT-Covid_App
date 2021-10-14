// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './pages/HomePage.dart';

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

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      color: Colors.lightGreen.shade100,
      child: Column(
        children: [
          Image.asset("images/coronadr.png"),
          Text("The Robotics Forums")
        ],
      ),
    );
  }
}
