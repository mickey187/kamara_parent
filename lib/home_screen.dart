// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './models/user.dart';
import 'package:google_fonts/google_fonts.dart';
import './attendance_screen.dart';

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
            elevation: 10,
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
                ],
              ),
            )),

            Expanded(
              child:GridView.count(
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    crossAxisCount: 2,
                    padding: EdgeInsets.all(5),
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: GestureDetector(
                          onTap: (){
                            final snackBar = SnackBar(
            content: const Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          },
                          child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          color: Colors.blueAccent,
                          
                          
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Center(
                                child: Icon(Icons.school_outlined, size: 70,color: Colors.white,),
                              ),
                              Center(
                                child: Text(
                                  "Grades",
                                  style: GoogleFonts.lato(
                                  textStyle: Theme.of(context).textTheme.overline,
                                  fontSize: 17,
                                  color: Colors.white
                                ),
                                  ),
                              )
                            ],
                          )
                        ),
                        )
                      ),

                       SizedBox(
                        width: 100,
                        height: 100,
                        child: GestureDetector(
                          onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceScreen()));
                          },
                          child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          color: Colors.green[400] ,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Center(
                                child: Icon(Icons.task_alt_outlined, size: 70,color: Colors.white,),
                              ),
                              Center(
                                child: Text(
                                  "Attendance",
                                   style: GoogleFonts.lato(
                                  textStyle: Theme.of(context).textTheme.overline,
                                  fontSize: 17,
                                  color: Colors.white
                                ),
                                  ),
                              )
                            ],
                          )
                        ),
                        )
                      ),

                       SizedBox(
                        width: 100,
                        height: 100,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          color: Colors.amberAccent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Center(
                                child: Icon(Icons.attach_money_outlined,size: 70,color: Colors.white,),
                              ),
                              Center(
                                child: Text(
                                  "Finance",
                                   style: GoogleFonts.lato(
                                  textStyle: Theme.of(context).textTheme.overline,
                                  fontSize: 17,
                                  color: Colors.white
                                ),
                                  ),
                              )
                            ],
                          )
                        ),
                      ),

                       SizedBox(
                        width: 100,
                        height: 100,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          color: Colors.redAccent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Center(
                                child: Icon(Icons.chat, size: 70,color: Colors.white,),
                              ),
                              Center(
                                child: Text(
                                  "Communication",
                                   style: GoogleFonts.lato(
                                  textStyle: Theme.of(context).textTheme.overline,
                                  fontSize: 17,
                                  color: Colors.white
                                ),
                                  ),
                              )
                            ],
                          )
                        ),
                      ),
                    ],
                    ) 
              )
      ],
    ));
  }
}

