import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './models/attendance_model.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {

  
  Future<Atttendance> _getAttendanceForCurrentMonth() async{

    final sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    String? studentId = sharedPreferences.getString("student_id");
    String url =
        "http://kamara.harambeeuniversity.edu.et/api/parent/attendance/getAttendanceForCurrentMonth/"+studentId.toString();
    print(url);

    var response = await http.get(
      Uri.parse(url)
      // ,
      // headers: <String, String>{
      //   "Content-Type": "application/json; charset=UTF-8",
      //   "Accept": "application/json; charset=UTF-8"
      // //   HttpHeaders.authorizationHeader: "Bearer $token"
      // },
    );


    if (response.statusCode == 200) {
      var attendance = Atttendance.fromJson(jsonDecode(response.body));
     
      

      return Atttendance.fromJson(jsonDecode(response.body));
    } else {
      // print(response.statusCode);
      throw Exception(response.statusCode);
    }
  }

  Future<Atttendance>? _attendanceBuilder;


FutureBuilder<Atttendance> buildAttendance(){
    //  List<Datum> attendanceList = [];
     List<Widget> attendanceList = [];
     var firstDayOfMonth = "";
  return FutureBuilder<Atttendance>(
    future: _attendanceBuilder,
    builder: (context, snapshot){
      print(snapshot.data);
      if (snapshot.hasData) {

        if (snapshot.data!.success) {
          print("fetched");

                attendanceList.add(makeDayListGrid("ሰኞ"));
                attendanceList.add(makeDayListGrid("ማክሰኞ"));
                attendanceList.add(makeDayListGrid("ረብዕ"));
                attendanceList.add(makeDayListGrid("ሐሙስ"));
                attendanceList.add(makeDayListGrid("አርብ"));
                attendanceList.add(makeDayListGrid("ቅዳሜ"));
                attendanceList.add(makeDayListGrid("እሁድ"));
                

                  for (var item in snapshot.data!.data) {
            Datum datum = Datum(
              fullName: item.fullName, streamType: item.streamType,
              sectionName: item.sectionName, classLabel: item.classLabel,
              status: item.status, date: item.date,day: item.day, studentId: item.studentId);

              var date = datum.date.split("-");
              Widget attendanceStatus = Center(child: Container(),);
              
              if (datum.status == "present") {
                attendanceStatus = Center(child: Icon(Icons.check_circle_outline,color: Colors.green, ),);
              }
              else if(datum.status == "absent"){
                attendanceStatus = Center(child: Icon(Icons.error_outline,color: Colors.red, ),);
              }

              else if(datum.status == "leave"){
                attendanceStatus = Center(child: Icon(Icons.sick_outlined,color: Colors.blue, ),);
              }
              else if(datum.status == "unknown"){
                attendanceStatus = Center(child: Icon(Icons.indeterminate_check_box_outlined,color: Colors.white,),);
              }

              if (date[2] == "01") {
                switch (item.day) {
                  case "Monday":{

                  }   
                  break;

                  case "Tuesday":{
                    for (var i = 0; i < 1; i++) {
                       attendanceList.add(makeDayListGrid(""));
                    }
                  }   
                  break;

                  case "Wednesday":{
                    for (var i = 0; i < 2; i++) {
                       attendanceList.add(makeDayListGrid(""));
                    }
                  }   
                  break;

                  case "Thursday":{
                    for (var i = 0; i < 3; i++) {
                       attendanceList.add(makeDayListGrid(""));
                    }
                  }   
                  break;

                  case "Friday":{
                    for (var i = 0; i < 4; i++) {
                       attendanceList.add(makeDayListGrid(""));
                    }
                  }   
                  break;

                  case "Satuday":{
                    for (var i = 0; i < 5; i++) {
                       attendanceList.add(makeDayListGrid(""));
                    }
                  }   
                  break;

                  case "Sunday":{
                    for (var i = 0; i < 6; i++) {
                       attendanceList.add(makeDayListGrid(""));
                    }
                  }   
                  break;
                  default:
                }
              }
              

              print(date[2]);
            

            attendanceList.add(
              SizedBox(
              width: 100,
              height: 450,
              child: Card(
                  //  elevation: 5,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10)
                  //         ),
                          color: Colors.amberAccent,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
              
                children: <Widget>[
                  Center(
                    child: Text(date[2])
                  ),
                  attendanceStatus,
                  
                
                ],
              )
              )
            )
            );

           
          }

          return GridView.count(
            crossAxisCount: 7,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            children: attendanceList,
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            );
        }
        

      }

      else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

      return const Center(
          child: CircularProgressIndicator(),
        );
    },
  );
}

Widget makeDayListGrid(String day){

return SizedBox(
              width: 100,
              height: 100,
              child: Card(
                  //  elevation: 5,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10)
                  //         ),
                          color: Colors.amberAccent,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
              
                children: <Widget>[
                  Center(
                    child: Text(day)
                  ),
                  
                
                ],
              )
              )
            );
}


  @override
  Widget build(BuildContext context) {

    setState(() {
      _attendanceBuilder = _getAttendanceForCurrentMonth();
    });

    return Scaffold(
        appBar: AppBar(
          title: Text("Student Attendance"),
          backgroundColor: Colors.orangeAccent,
        ),
        body:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[

                Padding(
                  padding: EdgeInsets.fromLTRB(5, 30, 5, 15),
                  child: Card(
                elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                color: Colors.orangeAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Text("December, 2021",
                          style: GoogleFonts.lato(
                                  textStyle: Theme.of(context).textTheme.overline,
                                  fontSize: 17
                                ),
                          )
                        ],
                      ),
                    ),
                      )
                    
                    ),
                    buildAttendance()
                  ],
                )
              )
                  ),
              
              
            ],
          ),
        
        );
  }
}
