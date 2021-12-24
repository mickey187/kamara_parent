// To parse this JSON data, do
//
//     final assasment = assasmentFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Assasment assasmentFromMap(String str) => Assasment.fromMap(json.decode(str));

String assasmentToMap(Assasment data) => json.encode(data.toMap());

class Assasment {
  Assasment({
    required this.succes,
    required this.message,
    required this.currentSemister,
    required this.token,
    required this.semister,
  });

  bool succes;
  String message;
  String currentSemister;
  String token;
  List<Semister> semister;

  factory Assasment.fromMap(Map<String, dynamic> json) => Assasment(
        succes: json["succes"],
        message: json["message"],
        currentSemister: json["currentSemister"],
        token: json["token"],
        semister: List<Semister>.from(
            json["semister"].map((x) => Semister.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "succes": succes,
        "message": message,
        "currentSemister": currentSemister,
        "token": token,
        "semister": List<dynamic>.from(semister.map((x) => x.toMap())),
      };
}

class Semister {
  Semister({
    required this.mark,
    required this.load,
    required this.assasment,
    required this.semister,
    required this.date,
  });

  String mark;
  String load;
  String assasment;
  String semister;
  String date;

  factory Semister.fromMap(Map<String, dynamic> json) => Semister(
        mark: json["mark"],
        load: json["load"],
        assasment: json["assasment"],
        semister: json["semister"],
        date: json["date"],
      );

  Map<String, dynamic> toMap() => {
        "mark": mark,
        "load": load,
        "assasment": assasment,
        "semister": semister,
        "date": date,
      };
}
