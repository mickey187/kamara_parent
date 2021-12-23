// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

class GradeItemCard extends StatefulWidget {
  final String assasment;
  final String value;
  
  GradeItemCard(this.assasment, this.value);

  @override
  _GradeItemCard createState() => _GradeItemCard(assasment, value);
}

class _GradeItemCard extends State<GradeItemCard> {
  final String assasment;
  final String value;
  _GradeItemCard(this.assasment, this.value);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shadowColor: Colors.white,
      margin: EdgeInsets.all(15),
      child: ListTile(
        title: Text(
          assasment,
          style: TextStyle(color: Colors.blue),
        ),
        subtitle: Text(value,
            style: TextStyle(
              color: Colors.green,
            )),
      ),
    );
  }
}
