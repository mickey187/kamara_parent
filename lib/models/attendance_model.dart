// To parse this JSON data, do
//
//     final atttendance = atttendanceFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Atttendance atttendanceFromJson(String str) => Atttendance.fromJson(json.decode(str));

String atttendanceToJson(Atttendance data) => json.encode(data.toJson());

class Atttendance {
    Atttendance({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool success;
    final String message;
    final List<Datum> data;

    factory Atttendance.fromJson(Map<String, dynamic> json) => Atttendance(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.fullName,
        required this.streamType,
        required this.sectionName,
        required this.classLabel,
        required this.status,
        required this.date,
        required this.day,
        required this.studentId,
    });

    final String fullName;
    final String streamType;
    final String sectionName;
    final String classLabel;
    final String status;
    final String date;
    final String day;
    final String studentId;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        fullName: json["full_name"],
        streamType: json["stream_type"],
        sectionName: json["section_name"],
        classLabel: json["class_label"],
        status: json["status"],
        date: json["date"],
        day: json["day"],
        studentId: json["student_id"],
    );

    Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "stream_type": streamType,
        "section_name": sectionName,
        "class_label": classLabel,
        "status": status,
        "date": date,
        "day": day
    };
}
