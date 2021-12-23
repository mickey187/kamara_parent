// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(child: Text("Home Screen",
      // ignore: unnecessary_new
      style: new TextStyle(
            fontSize: 25,
          ),
     ),),
      
    );
  }
}
