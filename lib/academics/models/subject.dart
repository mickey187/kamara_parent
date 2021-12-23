// To parse this JSON data, do
//
//     final subject = subjectFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Subject subjectFromJson(String str) => Subject.fromJson(json.decode(str));

String subjectToJson(Subject data) => json.encode(data.toJson());

class Subject {
  Subject({
    required this.succes,
    required this.message,
    required this.token,
    required this.data,
  });

  final bool succes;
  final String message;
  final String token;
  final List<Datum> data;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        succes: json["succes"],
        message: json["message"],
        token: json["token"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "succes": succes,
        "message": message,
        "token": token,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.subjectId,
    required this.subjectName,
    required this.teacherName,
    required this.grade
  });

  final String subjectId;
  final String subjectName;
  final String teacherName;
  final String grade;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        subjectId: json["subject_id"],
        subjectName: json["subject_name"],
        teacherName: json["teacher_name"],
        grade: json['grade'],
      );

  Map<String, dynamic> toJson() => {
        "subject_id": subjectId,
        "subject_name": subjectName,
        "teacher_name": teacherName,
        "grade": grade,
      };
}
