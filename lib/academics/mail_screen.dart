// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MailScreen extends StatefulWidget {
  const MailScreen({Key? key}) : super(key: key);

  @override
  _MailScreen createState() => _MailScreen();
}

class _MailScreen extends State<MailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: unnecessary_new
      body: Center(
        child: Text(
          "Mail Screen",
          // ignore: unnecessary_new
          style: new TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
