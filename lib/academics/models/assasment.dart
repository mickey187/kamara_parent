// To parse this JSON data, do
//
//     final assasment = assasmentFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Assasment assasmentFromJson(String str) => Assasment.fromJson(json.decode(str));

String assasmentToJson(Assasment data) => json.encode(data.toJson());

class Assasment {
  Assasment({
    required this.succes,
    required this.message,
    required this.currentSemister,
    required this.token,
    required this.semisterOne,
    required this.semisterTwo,
    required this.semisterThree,
    required this.semisterFour,
  });

  final bool succes;
  final String message;
  final String currentSemister;
  final String token;
  final List<SemisterOne> semisterOne;
  final List<dynamic> semisterTwo;
  final List<dynamic> semisterThree;
  final List<dynamic> semisterFour;

  factory Assasment.fromJson(Map<String, dynamic> json) => Assasment(
        succes: json["succes"],
        message: json["message"],
        currentSemister: json["currentSemister"],
        token: json["token"],
        semisterOne: List<SemisterOne>.from(
            json["semister_one"].map((x) => SemisterOne.fromJson(x))),
        semisterTwo: List<dynamic>.from(json["semister_two"].map((x) => x)),
        semisterThree: List<dynamic>.from(json["semister_three"].map((x) => x)),
        semisterFour: List<dynamic>.from(json["semister_four"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "succes": succes,
        "message": message,
        "currentSemister": currentSemister,
        "token": token,
        "semister_one": List<dynamic>.from(semisterOne.map((x) => x.toJson())),
        "semister_two": List<dynamic>.from(semisterTwo.map((x) => x)),
        "semister_three": List<dynamic>.from(semisterThree.map((x) => x)),
        "semister_four": List<dynamic>.from(semisterFour.map((x) => x)),
      };
}

class SemisterOne {
  SemisterOne({
    required this.mark,
    required this.load,
    required this.assasment,
    required this.semister,
    required this.date,
  });

  final String mark;
  final String load;
  final String assasment;
  final String semister;
  final String date;

  factory SemisterOne.fromJson(Map<String, dynamic> json) => SemisterOne(
        mark: json["mark"],
        load: json["load"],
        assasment: json["assasment"],
        semister: json["semister"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "mark": mark,
        "load": load,
        "assasment": assasment,
        "semister": semister,
        "date": date,
      };
}
