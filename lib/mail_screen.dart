// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MailScreen extends StatefulWidget {
  const MailScreen({Key? key}) : super(key: key);

  @override
  _MailScreen createState() => _MailScreen();
}

class _MailScreen extends State<MailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: unnecessary_new
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
         Padding(
           padding: EdgeInsets.fromLTRB(10, 25, 10, 15),
           child:  SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: Stack(
              // alignment: Alignment.topLeft,
              children: <Widget>[
                CustomPaint(
                  size: Size(480, 250),
                  painter: RPSCustomPainter(),
                ),
                CustomPaint(
                  size: Size(130, 130),
                  painter:RPSCustomPainter2()
                )
                
              ],
            ),
          )
           
           )
          
        ],
      )
    );
  }

  
}

class RPSCustomPainter extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    

  Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 92, 170, 231)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.radial(Offset(size.width*0.50,size.height*0.02),size.width*1.20,[Color(0x00304ffe),Color(0xffffffff)],[0.00,1.00]); 
         
    Path path0 = Path();
    path0.moveTo(size.width*0.0058958,size.height*0.9694800);
    path0.lineTo(size.width*0.0058958,size.height*0.7282800);
    path0.lineTo(size.width*0.0058958,size.height*0.4962000);
    path0.quadraticBezierTo(size.width*0.0058958,size.height*0.3092400,size.width*0.0058958,size.height*0.2468000);
    path0.cubicTo(size.width*0.0050833,size.height*0.1917200,size.width*0.0022500,size.height*0.0886400,size.width*0.0022500,size.height*0.0241600);
    path0.quadraticBezierTo(size.width*0.0617292,size.height*0.0224400,size.width*0.1298333,size.height*0.0234400);
    path0.lineTo(size.width*0.2510417,size.height*0.0234400);
    path0.lineTo(size.width*0.3744792,size.height*0.0234400);
    path0.lineTo(size.width*0.4991667,size.height*0.0234400);
    path0.lineTo(size.width*0.6225000,size.height*0.0234400);
    path0.lineTo(size.width*0.7491875,size.height*0.0234400);
    path0.quadraticBezierTo(size.width*0.8401042,size.height*0.0234400,size.width*0.8705208,size.height*0.0234400);
    path0.quadraticBezierTo(size.width*0.9963542,size.height*0.0223600,size.width*0.9945000,size.height*0.2608400);
    path0.lineTo(size.width*0.9945000,size.height*0.4962000);
    path0.lineTo(size.width*0.9945000,size.height*0.7328800);
    path0.lineTo(size.width*0.9945208,size.height*0.9705600);
    path0.lineTo(size.width*0.8732500,size.height*0.9694800);
    path0.lineTo(size.width*0.7467292,size.height*0.9694800);
    path0.lineTo(size.width*0.6225000,size.height*0.9694800);
    path0.lineTo(size.width*0.5034583,size.height*0.9694800);
    path0.lineTo(size.width*0.3774375,size.height*0.9694800);
    path0.lineTo(size.width*0.2535833,size.height*0.9694800);
    path0.lineTo(size.width*0.1321042,size.height*0.9694800);
    path0.lineTo(size.width*0.0058958,size.height*0.9694800);
    path0.close();

    canvas.drawPath(path0, paint0);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
class RPSCustomPainter2 extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    

  Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    paint0.shader = ui.Gradient.linear(Offset(size.width*0.01,size.height*0.98),Offset(size.width*0.98,size.height*0.02),[Color(0xff992ee6),Color(0xffffffff)],[0.00,1.00]); 
         
    Path path0 = Path();
    path0.moveTo(size.width*0.2530000,size.height*0.0159231);
    path0.quadraticBezierTo(size.width*0.4495385,size.height*0.0190769,size.width*0.4895385,size.height*0.0159231);
    path0.lineTo(size.width*0.7350000,size.height*0.0159231);
    path0.quadraticBezierTo(size.width*0.9674615,size.height*0.0386154,size.width*0.9717692,size.height*0.2570000);
    path0.quadraticBezierTo(size.width*0.9723846,size.height*0.3171538,size.width*0.9760769,size.height*0.4979231);
    path0.lineTo(size.width*0.9760769,size.height*0.7340769);
    path0.quadraticBezierTo(size.width*0.9663846,size.height*0.9766923,size.width*0.7350000,size.height*0.9798462);
    path0.cubicTo(size.width*0.6747692,size.height*0.9798462,size.width*0.5544615,size.height*0.9798462,size.width*0.4940769,size.height*0.9798462);
    path0.quadraticBezierTo(size.width*0.4250000,size.height*0.9744615,size.width*0.2530000,size.height*0.9798462);
    path0.quadraticBezierTo(size.width*0.0243077,size.height*0.9773077,size.width*0.0163846,size.height*0.7436923);
    path0.quadraticBezierTo(size.width*0.0157692,size.height*0.6824615,size.width*0.0121538,size.height*0.4979231);
    path0.lineTo(size.width*0.0121538,size.height*0.2520769);
    path0.quadraticBezierTo(size.width*0.0172308,size.height*0.0216154,size.width*0.2530000,size.height*0.0159231);
    path0.close();

    canvas.drawPath(path0, paint0);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
