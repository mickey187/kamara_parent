import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kamara_parent/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'color_loader.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();
  bool isProgressVisible = false;
  bool isAuthenticated = false;

  Future<LoginResponse> _getUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://kamara.harambeeuniversity.edu.et/api/parent/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print("it's all goooooooooooood");
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Future<LoginResponse>? _loginBuilder;

  FutureBuilder<LoginResponse> buildFutureBuilder() {
    return FutureBuilder<LoginResponse>(
      future: _loginBuilder,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.success) {
            // setState(() {
            //   isAuthenticated = true;
            // });
            // return Text(snapshot.data!.message);
            saveUserAccountInfo(
                snapshot.data!.token,
                snapshot.data!.parentData.name,
                snapshot.data!.parentData.email,
                snapshot.data!.studentData.studentId,
                snapshot.data!.studentData.fullName,
                snapshot.data!.studentData.streamType,
                snapshot.data!.studentData.classLabel,
                snapshot.data!.studentData.sectionName);
            savePassword(passwordInputController.text);
            goToHomePage();
          }

          else if(snapshot.data!.success == false){
           

          return Text("No");
          }
          // return Text(snapshot.data!.success.toString());

        } else if (snapshot.hasError) {
          print(snapshot.error);
          return  Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),child: Text('just an error'),);
        }

        return  Center(child: CircularProgressIndicator(),);
      },
    );
  }

  void goToHomePage() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  void savePassword(String password)async{
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("password", password);

  }

  void saveUserAccountInfo(
      String token,
      String name,
      String email,
      String student_id,
      String student_name,
      String stream_type,
      String class_label,
      String section) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
    sharedPreferences.setString("name", name);
    sharedPreferences.setString("email", email);
    sharedPreferences.setString("student_id", student_id.toString());
    sharedPreferences.setString("student_name", student_name);
    sharedPreferences.setString("stream_type", stream_type);
    sharedPreferences.setString("class_label", class_label);
    sharedPreferences.setString("section", section);

    
  }

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        //  MaterialApp(
        Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          // margin: EdgeInsets.only(top: 200.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 300,

                  child: Expanded(
                    child: ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/orange_background.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 100.0, bottom: 100.0),
                        child: Column(
                          children: const <Widget>[
                            Text(
                              "Kamara School",
                              style: TextStyle(
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              "Parent App",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 40.0,top: 50),
                  child: Text(
                    "Email",
                    style: TextStyle(color: Colors.grey, fontSize: 16.0),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        height: 30.0,
                        width: 1.0,
                        color: Colors.grey.withOpacity(0.5),
                        margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: emailInputController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your email',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email address';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 40.0),
                  child: Text(
                    "Password",
                    style: TextStyle(color: Colors.grey, fontSize: 16.0),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Row(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        child: Icon(
                          Icons.lock_open,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        height: 30.0,
                        width: 1.0,
                        color: Colors.grey.withOpacity(0.5),
                        margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: passwordInputController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isProgressVisible,
                  child: Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Expanded(child: buildFutureBuilder()),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: ElevatedButton(
                        child: Text("Login"),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isProgressVisible = true;
                              _loginBuilder = _getUser(
                                  emailInputController.text,
                                  passwordInputController.text);
                            });

                            //  if (isAuthenticated) {
                            //     Navigator.push(
                            //         context, MaterialPageRoute(builder: (context) => MyApp()));
                            //  }

                            //   var response = await http.get(Uri.parse("http://kamara.harambeeuniversity.edu.et/api/parent/login/"+emailInputController.text.toString()+"/"+passwordInputController.text.toString()));

                            //   if (response.statusCode == 200) {
                            //     var status = LoginResponse.fromJson(jsonDecode(response.body)).success;
                            //     var token = LoginResponse.fromJson(jsonDecode(response.body)).token;
                            //   print(token);
                            //   if (status && token.isNotEmpty) {

                            //     final sharedPref = await SharedPreferences.getInstance();
                            //     sharedPref.setString("token", token);
                            //     final st = sharedPref.getString("token");
                            //     print(st);
                            //         Navigator.push(
                            //         context, MaterialPageRoute(builder: (context) => MyApp()));
                            //       }
                            //   }

                            //  else if (response.statusCode == 401) {
                            //     print("Unauthneticated");
                            //   }

                          }
                        },
                      )),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          color: Colors.transparent,
                          child: Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            alignment: Alignment.center,
                            child: Text(
                              "DON'T HAVE AN ACCOUNT?",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                          onPressed: () => {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // );
  }
}

// class LoginScreen1 extends StatelessWidget {
//   final Color? primaryColor;
//   final Color? backgroundColor;
//   final AssetImage backgroundImage;

//   LoginScreen1({
//     Key? key,
//     this.primaryColor = Colors.green,
//     this.backgroundColor = Colors.white,
//     this.backgroundImage = const AssetImage("assets/images/full-bloom.png"),
//   });

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       body: SingleChildScrollView(
//         child:  Container(
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//             color: this.backgroundColor,
//           ),
//           // margin: EdgeInsets.only(top: 200.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.max,
//             children: <Widget>[
//               // Expanded(
//               //   child:  ClipPath(
//               //     clipper: MyClipper(),
//               //     child: Container(
//               //       decoration: BoxDecoration(
//               //         image:  DecorationImage(
//               //           image: this.backgroundImage,
//               //           fit: BoxFit.cover,
//               //         ),
//               //       ),
//               //       alignment: Alignment.center,
//               //       padding: EdgeInsets.only(top: 100.0, bottom: 100.0),
//               //       child: Column(
//               //         children: const <Widget>[
//               //           Text(
//               //             "Kamara School",
//               //             style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.orangeAccent),
//               //           ),
//               //           Text(
//               //             "Parent App",
//               //             style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.orangeAccent),
//               //           ),
//               //         ],
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               const Padding(
//                 padding: EdgeInsets.only(left: 40.0),
//                 child: Text(
//                   "Email",
//                   style: TextStyle(color: Colors.grey, fontSize: 16.0),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.grey.withOpacity(0.5),
//                     width: 1.0,
//                   ),
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                 child: Row(
//                   children: <Widget>[
//                      const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                       child: Icon(
//                         Icons.person_outline,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     Container(
//                       height: 30.0,
//                       width: 1.0,
//                       color: Colors.grey.withOpacity(0.5),
//                       margin: const EdgeInsets.only(left: 00.0, right: 10.0),
//                     ),
//                      const Expanded(
//                       child: TextField(
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'Enter your email',
//                           hintStyle: TextStyle(color: Colors.grey),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(left: 40.0),
//                 child: Text(
//                   "Password",
//                   style: TextStyle(color: Colors.grey, fontSize: 16.0),
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.grey.withOpacity(0.5),
//                     width: 1.0,
//                   ),
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                 child: Row(
//                   children: <Widget>[
//                     const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                       child: Icon(
//                         Icons.lock_open,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     Container(
//                       height: 30.0,
//                       width: 1.0,
//                       color: Colors.grey.withOpacity(0.5),
//                       margin: const EdgeInsets.only(left: 00.0, right: 10.0),
//                     ),
//                     const Expanded(
//                       child: TextField(
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: 'Enter your password',
//                           hintStyle: TextStyle(color: Colors.grey),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 20.0),
//                 padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: FlatButton(
//                         shape:  RoundedRectangleBorder(borderRadius:  BorderRadius.circular(30.0)),
//                         splashColor: this.primaryColor,
//                         color: this.primaryColor,
//                         child:  Row(
//                           children: <Widget>[
//                              const Padding(
//                               padding: EdgeInsets.only(left: 20.0),
//                               child: Text(
//                                 "LOGIN",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                              Expanded(
//                               child: Container(),
//                             ),
//                              Transform.translate(
//                               offset: const Offset(15.0, 0.0),
//                               child:  Container(
//                                 padding: const EdgeInsets.all(5.0),
//                                 child: FlatButton(
//                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
//                                   splashColor: Colors.white,
//                                   color: Colors.white,
//                                   child: Icon(
//                                     Icons.arrow_forward,
//                                     color: this.primaryColor,
//                                   ),
//                                   onPressed: () => {},
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                         onPressed: () => {},
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Container(
//                 margin: const EdgeInsets.only(top: 20.0),
//                 padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                 child: Row(
//                   children: <Widget>[
//                      Expanded(
//                       child: FlatButton(
//                         shape:  RoundedRectangleBorder(borderRadius:  BorderRadius.circular(30.0)),
//                         color: Colors.transparent,
//                         child: Container(
//                           padding: const EdgeInsets.only(left: 20.0),
//                           alignment: Alignment.center,
//                           child: Text(
//                             "DON'T HAVE AN ACCOUNT?",
//                             style: TextStyle(color: this.primaryColor),
//                           ),
//                         ),
//                         onPressed: () => {},
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );

//   }
// }

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
