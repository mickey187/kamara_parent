// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kamara_parent/login_screen_1.dart';
import 'package:kamara_parent/models/user.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreen createState() => _SettingScreen();
}

class _SettingScreen extends State<SettingScreen> {
  Future<UserAccountInfo>? _userAccountInfoBuilder;

  Future<UserAccountInfo> _getUserAccountInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.containsKey("token") &&
        sharedPreferences.containsKey("name")) {
      UserAccountInfo userAccountInfo = UserAccountInfo(
          name: sharedPreferences.getString("name").toString(),
          email: sharedPreferences.getString("email").toString(),
          token: sharedPreferences.getString("token").toString());
      return userAccountInfo;
    } else {
      throw Exception("error");
    }
  }

  FutureBuilder<UserAccountInfo> buildFutureBuilder() {
    return FutureBuilder<UserAccountInfo>(
      future: _userAccountInfoBuilder,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListTile(
            title: Text(
              "Username: " + snapshot.data!.name,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Email: " + snapshot.data!.email,
              style: TextStyle(color: Colors.white)),
            leading:              
               CircleAvatar(
              backgroundImage: AssetImage("assets/images/avatar_1.png"),
            ),
            
            trailing: Icon(Icons.edit),
            contentPadding: EdgeInsets.all(15),
            
          );
          // Card(
          //   child: ListTile(
          //     leading: FlutterLogo(size: 56.0),
          //     title: Text(snapshot.data!.name),
          //     subtitle: Text(snapshot.data!.email),
          //     trailing: Icon(Icons.more_vert),
          //   ),
          // );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

  bool _lights = false;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _userAccountInfoBuilder = _getUserAccountInfo();
    });

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.all(8.0),
            color: Colors.blueAccent,
            child:  buildFutureBuilder(),
            ),
          
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("General"),
          ),
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.all(8.0),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Account Settings"),
                    leading: Icon(Icons.account_box),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Logout"),
                    leading: Icon(Icons.logout),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () async {
                      final sharedPreferences =
                          await SharedPreferences.getInstance();
                      if (sharedPreferences.containsKey("token") &&
                          sharedPreferences.containsKey("name") &&
                          sharedPreferences.containsKey("email")) {
                        await sharedPreferences.clear();
                        print("it was cleared das vidanya");
                      }

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),
                  ListTile(
                    title: Text("Account Settings"),
                    leading: Icon(Icons.account_box),
                    trailing: Icon(Icons.arrow_right),
                  ),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text("Personalization"),
          ),
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: EdgeInsets.all(8.0),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text("Language"),
                    leading: Icon(Icons.language),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () {},
                  ),
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    value: _lights,
                    onChanged: (bool value) {
                      setState(() {
                        _lights = value;
                      });
                    },
                    secondary: const Icon(Icons.dark_mode),
                  ),
                  ListTile(
                    title: Text("Font Size"),
                    leading: Icon(Icons.font_download),
                    trailing: Icon(Icons.arrow_right),
                  ),
                ],
              )),
        ],
      ),
    ));
  }
}
