// ignore_for_file: prefer_const_constructors, unused_element

import 'dart:convert';
import 'dart:io';
// import 'dart:html';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:kamara_parent/academics/card.dart';
import 'package:kamara_parent/academics/grade.dart';
import 'package:kamara_parent/academics/http_service.dart';
import 'package:kamara_parent/academics/subject_card.dart';
import 'package:kamara_parent/academics/subject_detail.dart';
import 'models/subject.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

class SubjectScreen extends StatefulWidget {
  // final Function getState;

  SubjectScreen();

  @override
  _SubjectScreen createState() => _SubjectScreen();
}

class _SubjectScreen extends State<SubjectScreen> {
  List _items = [];
  // Function pageController;
  _SubjectScreen();

  FutureBuilder<Subject> _buildBody(BuildContext context) {
    final HttpService httpService = HttpService();
    return FutureBuilder<Subject>(
      future: httpService.getPosts(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Datum> _datemItem = [];
          for (var item in snapshot.data!.data) {
            Datum d = Datum(
                subjectId: item.subjectId,
                subjectName: item.subjectName,
                teacherName: item.teacherName,
                grade: item.grade);
            _datemItem.add(d);
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: _datemItem.length,
                itemBuilder: (BuildContext context, int index) {
                  return Grade(
                      _datemItem[index].subjectName,
                      _datemItem[index].teacherName,
                      "MORE",
                      SubjectDetails(
                          _datemItem[index].subjectId,
                          _datemItem[index].teacherName,
                          _datemItem[index].subjectName,
                          _datemItem[index].grade),
                      _datemItem[index].grade);
                });
          } else if (snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subjects"),
        backgroundColor: Colors.orange,
      ),
      body: _buildBody(context),
    );
  }
}
