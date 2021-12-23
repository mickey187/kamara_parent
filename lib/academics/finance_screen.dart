// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({Key? key}) : super(key: key);

  @override
  _FinanceScreen createState() => _FinanceScreen();
}

class _FinanceScreen extends State<FinanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Finanace Screen",
       style: new TextStyle(
            fontSize: 25,
          ),),),
    );
  }
}
