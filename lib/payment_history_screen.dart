
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kamara_parent/models/payment_history.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';


class PaymentHistory extends StatefulWidget {
  const PaymentHistory({ Key? key }) : super(key: key);

  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {

Future<PaymentHistoryModel> _getPaymentHistory()async{

     final sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    String? studentId = sharedPreferences.getString("student_id");
    String url =
        "http://kamara.harambeeuniversity.edu.et/api/parent/finance/getPaymentHistory/" +
            studentId.toString();
    print(url);
    var response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Accept": "application/json; charset=UTF-8",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      var paymentHistory = PaymentHistoryModel.fromJson(jsonDecode(response.body));
      print(paymentHistory.data[1].amountPayed.toString());

      return PaymentHistoryModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.statusCode);
    }
}

Future<PaymentHistoryModel>? _paymentHistoryBuilder;

FutureBuilder<PaymentHistoryModel> buildFutureBuilder(){

  List<Datum> paymentHistory = [];
  return FutureBuilder<PaymentHistoryModel>(
    future: _paymentHistoryBuilder,
    builder: (context, snapshot){

      if (snapshot.hasData) {
        
        for (var item in snapshot.data!.data) {
          Datum datum = Datum(
                        fullName: item.fullName,
                        studentId: item.studentId,
                        paymentType: item.paymentType,
                        amountPayed: item.amountPayed,
                        invoiceNo: item.invoiceNo,
                        paymentMonth: item.paymentMonth,
                        status: item.status
                        );
                paymentHistory.add(datum);
        }

        return ListView.builder(
          itemCount: paymentHistory.length,
          itemBuilder: (BuildContext context, index){
            return Padding(
                  padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                  child: 
                  Card(
                  color: Colors.amber[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                   
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                "Payment Type: " +
                                    paymentHistory[index].paymentType,
                                style: GoogleFonts.lato(
                                  textStyle: Theme.of(context).textTheme.overline,
                                  fontSize: 17
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                "Payment Month: " +
                                    paymentHistory[index].paymentMonth,
                                style: GoogleFonts.lato(
                                  textStyle: Theme.of(context).textTheme.overline,
                                  fontSize: 17
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                "Amount Paid: " +
                                    paymentHistory[index].amountPayed.toString(),
                                style: GoogleFonts.lato(
                                  textStyle: Theme.of(context).textTheme.overline,
                                  fontSize: 17
                                ),
                              ),
                            ),
                          ),
                         
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                "Invoice Number: " +
                                    paymentHistory[index].invoiceNo,
                                style: GoogleFonts.lato(
                                  textStyle: Theme.of(context).textTheme.overline,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:const EdgeInsets.fromLTRB(0, 5, 5, 5),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Text(
                                "Status: " + paymentHistory[index].status,
                                style: GoogleFonts.lato(
                                  textStyle: Theme.of(context).textTheme.overline,
                                  fontSize: 17
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                    )
                  ],
                )
                    
                    ),
                   );
          }
          );
      }

      else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
    },
  );
}

  @override
  Widget build(BuildContext context) {

    setState(() {
          _paymentHistoryBuilder = _getPaymentHistory();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Kamara Parent"),
        backgroundColor: Colors.orange
      ),
      body: Container(
        child: buildFutureBuilder(),
      ),
    );
  }
}