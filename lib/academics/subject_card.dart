// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SubjectCard extends StatefulWidget {
  final String name;
  final String subject;
  final String grade;
  SubjectCard(this.name, this.subject, this.grade);

  @override
  _SubjectCard createState() => _SubjectCard(name, subject, grade);
}

class _SubjectCard extends State<SubjectCard> {
  final String name;
  final String subject;
  final String grade;

  _SubjectCard(this.name, this.subject, this.grade);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: unnecessary_new
      body: Card(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          
                          subject,
                          style: TextStyle(
                              // color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'RobotoMono',
                              fontSize: 18),
                        ),
                        Text(
                          name,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'RobotoMono',
                              fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Text(
                          grade,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'RobotoMono',
                              fontSize: 25),
                        ),
                        Text(
                          "Total grade",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'RobotoMono',
                              fontSize: 18),
                        ),
                        CircularProgressIndicator(
                          semanticsValue:"85",
                          )
                      ],
                    )
                  ],
                ),
              ],
            ),

            //  padding: EdgeInsets.all(20),
          ),
        ),
        color: Colors.white,
        elevation: 1,
        shadowColor: Colors.black,
        // margin: EdgeInsets.all(2),
      ),
    );
  }
}
