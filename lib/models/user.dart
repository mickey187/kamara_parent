// // To parse this JSON data, do
// //
// //     final loginRequest = loginRequestFromJson(jsonString);


// import 'dart:convert';

// LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));

// String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

// class LoginRequest {
//   final String email;
//     final String password;
//     LoginRequest({
//         required this.email,
//         required this.password,
//     });

    

//     factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
//         email: json["email"],
//         password: json["password"],
//     );

//     Map<String, dynamic> toJson() => {
//         "email": email,
//         "password": password,
//     };
// }


// // To parse this JSON data, do
// //
// //     final loginResponse = loginResponseFromJson(jsonString);



// LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

// String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

// class LoginResponse {
//     LoginResponse({
//         required this.success,
//         required this.message,
//         required this.token,
//     });

//     final bool success;
//     final String message;
//     final String token;

//     factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
//         success: json["success"],
//         message: json["message"],
//         token: json["token"],
//     );

//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "token": token,
//     };
// }


// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);
// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    LoginResponse({
        required this.success,
        required this.message,
        required this.token,
        required this.parentData,
        required this.studentData,
    });

    final bool success;
    final String message;
    final String token;
    final ParentData parentData;
    final StudentData studentData;

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"],
        message: json["message"],
        token: json["token"],
        parentData: ParentData.fromJson(json["parent_data"]),
        studentData: StudentData.fromJson(json["student_data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "token": token,
        "parent_data": parentData.toJson(),
        "student_data": studentData.toJson(),
    };
}

class ParentData {
    ParentData({
        required this.id,
        required this.userId,
        required this.name,
        required this.email,
        required this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    final int id;
    final String userId;
    final String name;
    final String email;
    final dynamic emailVerifiedAt;
    final DateTime createdAt;
    final DateTime updatedAt;

    factory ParentData.fromJson(Map<String, dynamic> json) => ParentData(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class StudentData {
    StudentData({
        required this.studentId,
        required this.fullName,
        required this.streamType,
        required this.classLabel,
        required this.sectionName,
    });

    final String studentId;
    final String fullName;
    final String streamType;
    final String classLabel;
    final String sectionName;

    factory StudentData.fromJson(Map<String, dynamic> json) => StudentData(
        studentId: json["student_id"],
        fullName: json["full_name"],
        streamType: json["stream_type"],
        classLabel: json["class_label"],
        sectionName: json["section_name"],
    );

    Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "full_name": fullName,
        "stream_type": streamType,
        "class_label": classLabel,
        "section_name": sectionName,
    };
}

class UserAccountInfo{

  final String name;
  final String email;
  final String token;

  UserAccountInfo(
    {required this.name,
    required this.email,
    required this.token}
  ){

  }
}
