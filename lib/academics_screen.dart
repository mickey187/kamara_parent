// ignore_for_file: prefer_const_constructors, unused_element

import 'dart:convert';
// import 'dart:html';

import 'package:flutter/material.dart';
import './subject.dart';
import 'dart:async';
import 'main.dart';
import './home_screen.dart';
import 'package:flutter/services.dart' show rootBundle;

class AcademicsScreen extends StatefulWidget {
  const AcademicsScreen({Key? key}) : super(key: key);

  @override
  _AcademicsScreen createState() => _AcademicsScreen();
}

class _AcademicsScreen extends State<AcademicsScreen> {
  List _items = [];

  MyApp myApp = new MyApp();
  
  _AcademicsScreen() {
    readJson();
  }

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/subject.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            // Display the data loaded from sample.json
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.amber,
                    elevation: 3,
                    margin: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () => {},
                      child: ListTile(
                        // leading: Text(_items[index]["picture"]),
                        title: Text(_items[index]["subject"]),
                        subtitle: Text(_items[index]["teacherName"]),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
