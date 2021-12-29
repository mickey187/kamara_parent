import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // _navigateToHome();

  }

  _navigateToHome()async{
    await Future.delayed(Duration(milliseconds: 1500),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CheckAuth()));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  Center(
      child: AnimatedSplashScreen(
      splash: "assets/icon/icon.png",
      splashIconSize: 150,
      duration: 2000,
      nextScreen: CheckAuth(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.white
      )
    ) ,
    );
      

  }
}