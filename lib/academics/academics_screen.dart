// ignore_for_file: prefer_const_constructors, unused_element

import 'dart:convert';
import 'dart:io';
// import 'dart:html';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:test/academics/card.dart';
import 'package:test/academics/http_service.dart';
import 'package:test/academics/subject_card.dart';
import 'package:test/academics/subject_detail.dart';
import 'package:test/academics/subject_screen.dart';
import 'academics/models/subject.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

class AcademicsScreen extends StatefulWidget {
  const AcademicsScreen();

  @override
  _AcademicsScreen createState() => _AcademicsScreen();
}

class _AcademicsScreen extends State<AcademicsScreen> {
  
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
                      CardType("Grade",
                          "Here appears some associated information", "Grades",SubjectScreen()),
                      CardType("Attendance",
                          "Here appears some associated information", "Atendance",SubjectScreen()),
    ]));
  }
}