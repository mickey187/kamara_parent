
import 'package:meta/meta.dart';
import 'dart:convert';

UnpaidBill unpaidBillFromJson(String str) => UnpaidBill.fromJson(json.decode(str));

String unpaidBillToJson(UnpaidBill data) => json.encode(data.toJson());

class UnpaidBill {
    UnpaidBill({
        required this.success,
        required this.message,
        required this.data,
    });

    final bool success;
    final String message;
    final List<Datum> data;

    factory UnpaidBill.fromJson(Map<String, dynamic> json) => UnpaidBill(
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
        required this.amount,
        required this.discountPercent,
        required this.status,
        required this.invoiceNumber,
        required this.dueYearMonth,
    });

    final String studentId;
    final String fullName;
    final String paymentType;
    final int amount;
    final int discountPercent;
    final String status;
    final String invoiceNumber;
    final String dueYearMonth;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        studentId: json["student_id"],
        fullName: json["full_name"],
        paymentType: json["payment_type"],
        amount: json["amount"],
        discountPercent: json["discount_percent"],
        status: json["status"],
        invoiceNumber: json["invoice_number"],
        dueYearMonth: json["due_year_month"],
    );

    Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "full_name": fullName,
        "payment_type": paymentType,
        "amount": amount,
        "discount_percent": discountPercent,
        "status": status,
        "invoice_number": invoiceNumber,
        "due_year_month": dueYearMonth,
    };
}



// To parse this JSON data, do
//
//     final paymentHistory = paymentHistoryFromJson(jsonString);

