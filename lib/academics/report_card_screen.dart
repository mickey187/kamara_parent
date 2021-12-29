import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:kamara_parent/academics/subject_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportCard extends StatefulWidget {
  ReportCard();
  @override
  _ReportCard createState() => _ReportCard();
}

class _ReportCard extends State<ReportCard> {
  String URL = '';
  _ReportCard() {
    getStudentDataFromSharedPref();
  }

  Future<String> getStudentDataFromSharedPref() async {
    String student_full_name = '';
    String student_id = '';
    String class_label = '';
    String stream = '';
    String section = '';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("student_id") && prefs.containsKey("student_name")) {
      student_id = prefs.getString("student_id").toString();
      student_full_name = prefs.getString("student_name").toString();
      class_label = prefs.getString("class_label").toString();
      stream = prefs.getString("stream_type").toString();
      section = prefs.getString("section").toString();
      URL = "http://kamara.harambeeuniversity.edu.et/storage/report_card/" +
          class_label +
          "_" +
          stream +
          "_" +
          section +
          "/" +
          student_full_name +
          student_id +
          ".jpg";
      return URL;
    } else {
      throw Exception("could not load data");
    }
  }

  FutureBuilder<String> buildStudentData() {
    return FutureBuilder<String>(
        future: getStudentDataFromSharedPref(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              // child: GestureDetector(
              child: ExtendedImage.network(
                snapshot.data!,
                fit: BoxFit.fill,
                //enableLoadState: false,
                mode: ExtendedImageMode.gesture,
                initGestureConfigHandler: (state) {
                  return GestureConfig(
                    minScale: 0.9,
                    animationMinScale: 0.7,
                    maxScale: 3.0,
                    animationMaxScale: 3.5,
                    speed: 1.0,
                    inertialSpeed: 100.0,
                    initialScale: 1.0,
                    inPageView: false,
                    initialAlignment: InitialAlignment.center,
                  );
                },
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report Card"),
        backgroundColor: Colors.orange,
      ),
      body: Stack(
        children: <Widget>[
          buildStudentData(),
        ],
      ),
      floatingActionButton: floatingButton(),
    );
  }

  TextEditingController searchController = new TextEditingController();
  String dropdownValue = 'One';
  Widget floatingButton() {
    return Container(
      child: FloatingActionButton.extended(
        onPressed: () => {},
        label: Text("semister"),
        icon: Icon(Icons.list),
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
