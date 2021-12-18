// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SubjectDetails extends StatefulWidget {
  const SubjectDetails({Key? key}) : super(key: key);

  @override
  _SubjectDetails createState() => _SubjectDetails();
}

class _SubjectDetails extends State<SubjectDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Subject Screen",
          // ignore: unnecessary_new
          style: new TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
