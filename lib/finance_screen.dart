// ignore_for_file: prefer_const_constructors, unnecessary_new, unnecessary_const

import 'package:flutter/material.dart';
import 'package:kamara_parent/payment_history_screen.dart';
import './unpaid_bills.dart';
import 'package:google_fonts/google_fonts.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({Key? key}) : super(key: key);

  @override
  _FinanceScreen createState() => _FinanceScreen();
}

class _FinanceScreen extends State<FinanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        Padding(
          padding: EdgeInsets.fromLTRB(15, 30, 15, 5),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [

                SizedBox(
                  width: 100,
                  height: 100,
                  child: FlutterLogo(size: 56,),
                ),
                ListTile(
                  // leading: Icon(Icons.arrow_drop_down_circle),
                  title: const Text('Unpaid Bills'),
                  subtitle: Text(
                    'Secondary Text',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'You have two unpaid bills for more click the more info button',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {

                         Navigator.push(context, MaterialPageRoute(builder: (context) => UnpaidBills()));
                      },
                      child: Text("MORE INFO"),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        primary: const Color(0xFF6200EE),
                        textStyle: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                // Image.asset('assets/card-sample-image.jpg'),
                // Image.asset('assets/card-sample-image-2.jpg'),
              ],
            ),
          ),
        ),

            Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [

                SizedBox(
                  width: 100,
                  height: 100,
                  child: FlutterLogo(size: 56,),
                ),
                ListTile(
                  // leading: Icon(Icons.arrow_drop_down_circle),
                  title: const Text('Payment History'),
                  subtitle: Text(
                    'Secondary Text',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'To see your previously paid bills tap the more info button',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {

                         Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentHistory()));
                      },
                      child: Text("MORE INFO"),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        primary: const Color(0xFF6200EE),
                        textStyle: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                // Image.asset('assets/card-sample-image.jpg'),
                // Image.asset('assets/card-sample-image-2.jpg'),
              ],
            ),
          ),
        )
      ],
    ),
        )
    );
  }
}
