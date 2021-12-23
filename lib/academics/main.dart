// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import './academics_screen.dart';
import './finance_screen.dart';
import './home_screen.dart';
import './mail_screen.dart';
import './setting_screen.dart';

void main() {
  runApp(const MyApp());
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
  PageController pageController = PageController(initialPage: 2);

  List<Widget> _screen = [];

  String swapList = "";

  int _currentIndex = 2;

  bool swap = true;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onSubjectPageChanged(String list) {
    setState(() {
      swap = !swap;
      swapList = list;
    });
  }

  void _onAcademicPageChanged() {
    setState(() {
      swap = !swap;
    });
  }

  void _onItemTaped(int selectedIndex) {
    pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    // _currentIndex = 2;
    Widget swapWidget = Container();

    // if (swap) {
    //   swapWidget = AcademicsScreen(_onSubjectPageChanged);
    // } else {
    //   swapWidget = SubjectDetails(swapList);
    // }

    return Scaffold(
      // ignore: duplicate_ignore
      appBar: AppBar(
        title: Text("Kamara Parent"),
        backgroundColor: Colors.orange,
        // leading: Icon(Icons.arrow_back),
      ),
      body: PageView(
        controller: pageController,
        children: _screen = [
          AcademicsScreen(),
          // swapWidget,
          FinanceScreen(),
          HomeScreen(),
          MailScreen(),
          SettingScreen(),
          // SubjectDetails()
        ],
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
