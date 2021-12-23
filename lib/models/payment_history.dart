// To parse this JSON data, do
//
//     final paymentHistoryModel = paymentHistoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PaymentHistoryModel paymentHistoryModelFromJson(String str) => PaymentHistoryModel.fromJson(json.decode(str));

String paymentHistoryModelToJson(PaymentHistoryModel data) => json.encode(data.toJson());

class PaymentHistoryModel {
    PaymentHistoryModel({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool success;
    final String message;
    final List<Datum> data;

    factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) => PaymentHistoryModel(
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
        required this.studentId,
        required this.fullName,
        required this.paymentType,
        required this.amountPayed,
        required this.invoiceNo,
        required this.paymentMonth,
        required this.status,
    });

    final String studentId;
    final String fullName;
    final String paymentType;
    final int amountPayed;
    final String invoiceNo;
    final String paymentMonth;
    final String status;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        studentId: json["student_id"],
        fullName: json["full_name"],
        paymentType: json["payment_type"],
        amountPayed: json["amount_payed"],
        invoiceNo: json["invoice_no"],
        paymentMonth: json["payment_month"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "full_name": fullName,
        "payment_type": paymentType,
        "amount_payed": amountPayed,
        "invoice_no": invoiceNo,
        "payment_month": paymentMonth,
        "status": status,
    };
}
