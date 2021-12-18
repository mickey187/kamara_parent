// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreen createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Setting Screen",
       // ignore: unnecessary_new
       style: new TextStyle(
            fontSize: 25,
          ),
      ),),
    );
  }
}
