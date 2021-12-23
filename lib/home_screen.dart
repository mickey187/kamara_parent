// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './models/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  Future<UserAccountInfo>? _userAccountInfoBuilder;
  Future<StudentData>? _studentDataBuilder;

  Future<UserAccountInfo> _getUserAccountInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.containsKey("token") &&
        sharedPreferences.containsKey("name")) {
      UserAccountInfo userAccountInfo = UserAccountInfo(
          name: sharedPreferences.getString("name").toString(),
          email: sharedPreferences.getString("email").toString(),
          token: sharedPreferences.getString("token").toString());
      return userAccountInfo;
    } else {
      throw Exception("error");
    }
  }

  // _HomeScreen(){
  //   setState(() {
  //     _userAccountInfoBuilder = _getUserAccountInfo();
  //   });
  // }

  FutureBuilder<UserAccountInfo> buildFutureBuilder() {
    return FutureBuilder<UserAccountInfo>(
      future: _userAccountInfoBuilder,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Card(
            child: ListTile(
              leading: FlutterLogo(size: 56.0),
              title: Text(snapshot.data!.name),
              subtitle: Text(snapshot.data!.email),
              trailing: Icon(Icons.more_vert),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

  Future<StudentData> _getStudentData() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.containsKey("student_id") &&
        sharedPreferences.containsKey("student_name")) {
      StudentData studentData = StudentData(
          studentId: sharedPreferences.getString("student_id").toString(),
          fullName: sharedPreferences.getString("student_name").toString(),
          streamType: sharedPreferences.getString("strema_type").toString(),
          classLabel: sharedPreferences.getString("class_label").toString(),
          sectionName: sharedPreferences.getString("section").toString());

      return studentData;
    } else {
      throw Exception("could not load data");
    }
  }

  FutureBuilder<StudentData> buildStudentData() {
    return FutureBuilder<StudentData>(
      future: _getStudentData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.lightBlueAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                      width: 130,
                      height: 150,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "http://kamara.harambeeuniversity.edu.et/storage/student_image/" +
                                snapshot.data!.studentId.toString() +
                                ".JPG"),
                        backgroundColor: Colors.brown.shade800,
                        child: const Text(''),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Chip(
                        backgroundColor: Colors.white54,
                        label: Text("Name: "+snapshot.data!.fullName.toString())),
                    Chip(
                        backgroundColor: Colors.white54,
                        label: Text("ID: "+snapshot.data!.studentId.toString())),
                    Chip(
                        backgroundColor: Colors.white54,
                        label: Text("Class: "+snapshot.data!.classLabel.toString())),
                    // Chip(
                    //   backgroundColor: Colors.white54,
                    //     label:  Text("Section: "+snapshot.data!.sectionName.toString())
                    //   )
                  ],
                )
                  )
              ],
            ),
          );
        }

        return const CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _userAccountInfoBuilder = _getUserAccountInfo();
      _studentDataBuilder = _getStudentData();
    });
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(10, 15, 15, 10),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  buildStudentData(),
                  // Center(
                  //   child:
                  //   ElevatedButton(
                  //     child: Text("click me"),
                  //     onPressed: (){
                  //       setState(() {
                  //         _userAccountInfoBuilder = _getUserAccountInfo();
                  //       });
                  //     },
                  //     ),
                  // )
                ],
              ),
            )),
      ],
    ));
  }
}
