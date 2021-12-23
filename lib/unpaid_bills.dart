import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kamara_parent/models/user.dart';
import 'package:kamara_parent/models/finance_model.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class UnpaidBills extends StatefulWidget {
  const UnpaidBills({Key? key}) : super(key: key);

  @override
  _UnpaidBillsState createState() => _UnpaidBillsState();
}

class _UnpaidBillsState extends State<UnpaidBills> {
  // Future<List<User>> _getUser() async {
  //   var data = await http.get(Uri.parse(
  //       "http://kamara.harambeeuniversity.edu.et/api/finance/getPaymentType"));
  //   var jsonData = json.decode(data.body);
  //   List<User> users = [];
  //   for (var u in jsonData) {
  //     User user = User(u["payment_type"], u["recurring_type"]);
  //     users.add(user);
  //   }

  //   return users;
  // }

  Future<UnpaidBill> _getUnpaidBill() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    String? studentId = sharedPreferences.getString("student_id");
    String url =
        "http://kamara.harambeeuniversity.edu.et/api/parent/finance/getOutstandingBill/" +
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
      var unpaidJson = UnpaidBill.fromJson(jsonDecode(response.body));
      

      return UnpaidBill.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<UnpaidBill>? _unpaidBillBuilder;

  FutureBuilder<UnpaidBill> buildFutureBuilder() {
    List<Datum> unpaidBillList = [];
    return FutureBuilder<UnpaidBill>(
      future: _unpaidBillBuilder,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          for (var item in snapshot.data!.data) {
            Datum datum = Datum(
                studentId: item.studentId,
                fullName: item.fullName,
                paymentType: item.paymentType,
                amount: item.amount,
                discountPercent: item.discountPercent,
                status: item.status,
                invoiceNumber: item.invoiceNumber,
                dueYearMonth: item.dueYearMonth);
            unpaidBillList.add(datum);
          }

          return ListView.builder(
              itemCount: unpaidBillList.length,
              itemBuilder: (BuildContext context, int index) {
                // return ListTile(
                //   title: Text(snapshot.data[index].payment_type),
                //   subtitle: Text(snapshot.data[index].recurring_type),

                // );
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
                                    unpaidBillList[index].paymentType,
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
                                "Due Month: " +
                                    unpaidBillList[index].dueYearMonth,
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
                                "Amount: " +
                                    unpaidBillList[index].amount.toString(),
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
                                    unpaidBillList[index].invoiceNumber,
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
                                "Status: " + unpaidBillList[index].status,
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
                    // ListTile(
                    //   leading: Icon(
                    //     Icons.payment,
                    //     color: Colors.green,
                    //     size: 60.0,
                    //   ),
                    //   title:
                    //   Text(
                    //    "Payment Type: "+ unpaidBillList[index].paymentType,
                    //    style: TextStyle(fontSize: 20),
                    //     ),
                    //   subtitle: Text(unpaidBillList[index].amount.toString()),
                    //   trailing: Icon(Icons.more_vert),
                    // ),
                    ),
                   );
              });
        } else if (snapshot.hasError) {
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
      _unpaidBillBuilder = _getUnpaidBill();
    });
    return Scaffold(
      appBar: AppBar(
          title: const Text("Kamara Parent"),
          backgroundColor: Colors.orange),
      body: Container(
        child: buildFutureBuilder(),
      ),
    );
  }
}

// FutureBuilder(
//             // future: _getUser(),
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.data == null) {
//                 return Container(
//                   child: Center(
//                     child: Text("loading"),
//                   ),
//                 );
//               } else {
//                 return ListView.builder(
//                     itemCount: snapshot.data.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       // return ListTile(
//                       //   title: Text(snapshot.data[index].payment_type),
//                       //   subtitle: Text(snapshot.data[index].recurring_type),

//                       // );
//                       return   Card(
//       child: ListTile(
//         leading: FlutterLogo(size: 56.0),
//         title: Text(snapshot.data[index].payment_type),
//         subtitle: Text(snapshot.data[index].recurring_type),
//         trailing: Icon(Icons.more_vert),
//       ),
//     );

//                     });
//               }
//             })
