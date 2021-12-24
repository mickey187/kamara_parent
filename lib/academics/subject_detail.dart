// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kamara_parent/academics/grade_item_card.dart';
import 'package:kamara_parent/academics/http_service.dart';
import 'package:kamara_parent/academics/models/assasment.dart';
import 'package:kamara_parent/academics/models/subject.dart';
import 'package:kamara_parent/academics/subject_card.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

class SubjectDetails extends StatefulWidget {
  final String id;
  final String teacherName;
  final String subject;
  final String grade;

  SubjectDetails(this.id, this.teacherName, this.subject, this.grade,
      {Key? key})
      : super(key: key) {
    // print("Ab Clicked");
  }

  @override
  _SubjectDetails createState() =>
      // ignore: no_logic_in_create_state
      _SubjectDetails(id, teacherName, subject, grade);
}

class _SubjectDetails extends State<SubjectDetails> {
  final String id;
  final String teacherName;
  final String subject;
  final String grade;
  _SubjectDetails(this.id, this.teacherName, this.subject, this.grade) {
    // print(id);
    readJson();
  }
  List _items = [];

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/student_grade.json');
    final data = await json.decode(response);

    setState(() {
      _items = data["items"];
    });
  }

  FutureBuilder<Assasment> _buildAssasment(BuildContext context) {
    final HttpService httpService = HttpService();
    print(httpService.getAssasment(context, id));
    return FutureBuilder<Assasment>(
      future: httpService.getAssasment(context, id),
      builder: (context, snapshot) {
        print(snapshot.data.toString());
        if (snapshot.hasData) {
          print("Abraham --- >>  ");
          List<Semister> _semisterItem = [];
          
          for (var item in snapshot.data!.semister) {
            Semister d = Semister(
                mark: item.mark,
                assasment: item.assasment,
                load: item.load,
                semister: item.semister,
                date: item.date);
            _semisterItem.add(d);
          }

          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: _semisterItem.length,
                itemBuilder: (BuildContext context, int index) {
                  return GradeItemCard(_semisterItem[index].assasment,
                      _semisterItem[index].mark);
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
          title: Text("Subject Details"),
          backgroundColor: Colors.orange,
        ),
        body:
            //  _buildAssasment(context),
            Column(
          children: [
            Container(
                height: 200,
                width: 400,
                child: SubjectCard(teacherName, subject, grade.toString())),
            Container(
              height: 500,
              width: 400,
              child: _buildAssasment(context),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: _items.length,
              //     itemBuilder: (context, index) {
              //       return GradeItemCard(
              //           _items[index]["assasment"].toString(),
              //           _items[index]["mark"].toString());
              //     },
              //   ),
              // )
            ),
            // _buildBody(context),
          ],
        ));
  }
}
