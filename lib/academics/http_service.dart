import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kamara_parent/academics/models/Assasment.dart';
import 'package:kamara_parent/academics/models/subject.dart';

class HttpService {
  final String postsURL =
      "http://kamara.harambeeuniversity.edu.et/api/parent/getStudentSubject/311483";


  Future<Subject> getPosts(BuildContext context) async {
    var response = await http.get(Uri.parse(postsURL));
    if (response.statusCode == 200) {
      return Subject.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Unable to retrieve posts.");
    }
  }

  List<Subject> parseSubject(String responseBody) {
    var parsed = jsonDecode(responseBody);
    return parsed.map<Subject>((json) => Subject.fromJson(json)).toList();
  }

  Future<List<Datum>> getPostsForDatum() async {
    var response = await http.get(Uri.parse(postsURL));
    dynamic res = Subject.fromJson(jsonDecode(response.body)).data;
    print(res);
    if (response.statusCode == 200) {
      return parseDatum(res);
    } else {
      throw "Unable to retrieve posts.";
    }
  }

  List<Datum> parseDatum(var responseBody) {
    var parsed = jsonDecode(responseBody);
    return parsed.map<Datum>((json) => Datum.fromJson(json)).toList();
  }

  Future<Assasment> getAssasment(BuildContext context, subject_id) async {
    // subject_id;
      final String assasmentGetURL =
      "http://kamara.harambeeuniversity.edu.et/api/parent/getStudentSubjectAssasment/311483/"+subject_id;
    var response = await http.get(Uri.parse(assasmentGetURL));
    if (response.statusCode == 200) {
      print(response.body);

      return Assasment.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Unable to retrieve posts.");
    }
  }
}
