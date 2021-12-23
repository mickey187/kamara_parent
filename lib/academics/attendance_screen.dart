import 'package:flutter/material.dart';
import 'package:kamara_parent/academics/subject_screen.dart';

class AttendanceScreen extends StatefulWidget {
  AttendanceScreen();
  @override
  _AttendanceScreen createState() => _AttendanceScreen();
}

class _AttendanceScreen extends State<AttendanceScreen> {
  _AttendanceScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Attendance"),
          backgroundColor: Colors.orange,
        ),
        body: const Center(
          child: Text(
            "Attendance",
            style: TextStyle(fontSize: 20),
          ),
        ));
  }
}
