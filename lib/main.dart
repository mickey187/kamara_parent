// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './academics_screen.dart';
import './finance_screen.dart';
import './home_screen.dart';
import './mail_screen.dart';
import './setting_screen.dart';
import './login_screen_1.dart';


void main() {
  runApp( CheckAuth());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: prefer_final_fields
  PageController _pageController = PageController(initialPage: 2);

  // ignore: prefer_final_fields
  List<Widget> _screen = [
    AcademicsScreen(),
    FinanceScreen(),
    HomeScreen(),
    MailScreen(),
    SettingScreen()
  ];

  int _currentIndex = 2;
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTaped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  void callBack(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    // _currentIndex = 2;
    return Scaffold(
      // ignore: duplicate_ignore
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text("Kamara Parent"),
        backgroundColor: Colors.orange,
      ),
      body: PageView(
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.orange,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedFontSize: 18,
        unselectedFontSize: 14,
        onTap: _onItemTaped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: "Academics",
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: "Finance",
            // backgroundColor: Colors.orange
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            // backgroundColor: Colors.orange
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: "Mail",
            // backgroundColor: Colors.orange
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting",
            // backgroundColor: Colors.orange
          )
        ],
      ),
    );
  }
}

class CheckAuth extends StatefulWidget {
  const CheckAuth({ Key? key }) : super(key: key);

  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {

  Future<bool>? _authState;
  
  

  Future<bool> _getAuthState() async {

    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("email")!= null && sharedPreferences.getString("password")!= null){
      
      return true;
    }
    return false;

  }

  FutureBuilder<bool> buildFutureBuilder() {
    return FutureBuilder<bool>(
      future: _authState,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.toString() == "true") {
            return MyApp();
          }

          else if(snapshot.data.toString() == "false"){
            return LoginPage();
          }
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

  
  @override
  Widget build(BuildContext context) {

    setState(() {
      _authState = _getAuthState();
    });
    return buildFutureBuilder();
  }
}
