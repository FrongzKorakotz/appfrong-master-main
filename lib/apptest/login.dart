import 'package:appfrong/apptest/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'register.dart';

var id;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email, password;
  final formkey = GlobalKey<FormState>();
  final database = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF262d43),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                        colors: [Color(0xFFb3c4ff), Color(0xFFb3c4ff)])),
                margin: EdgeInsets.all(32),
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    showAppNames(),
                    showLogo(),
                    mySizebox1(),
                    buildTextFieldEmail(),
                    buildTextFieldPassword(),
                    buildButtonSignIn(),
                    Text('______________________________________'),
                    buildButtonSignUp(),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget showAppNames() {
    return Text(
      'Memory Today App',
      style: TextStyle(
        color: Color(0xFF262d43),
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget showLogo() {
    return Container(
        width: 130.0, height: 140.0, child: Image.asset('images/logoo.png'));
  }

  // Container buildButtonSignIn() {
  //   return Container(
  //       //constraints: FlatButton.expand(height: 50),
  //       child: Text("Sign in",
  //           textAlign: TextAlign.center,
  //           style: TextStyle(fontSize: 18, color: Colors.white)),
  //       decoration: FlatButton(
  //           borderRadius: BorderRadius.circular(16), color: Colors.green[200], child: null,),
  //       margin: EdgeInsets.only(top: 16),
  //       padding: EdgeInsets.all(12));
  // }
  Future<Null> loginserve() async {
    var data = database.child("user");
    await data.child(email).once().then((DataSnapshot snapshot) {
      print('Data ======>${snapshot.value}');
      if ('${snapshot.value}' == 'null') {
        print('user');
      } else if (password == '${snapshot.value['password']}') {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => Home(),
        );
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
      } else {
        print('รหัสไม่ถูก');
      }
    });
  }

  Widget buildButtonSignIn() => Center(
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 16.0),
          width: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: FlatButton(
              color: Colors.red[700],
              onPressed: () {
                if (email == null ||
                    email.isEmpty ||
                    password == null ||
                    password.isEmpty) {
                  normalDialog(context, 'กรุณากรอกข้อมูลให้ครบ');
                } else {
                  loginserve();
                }
              },
              child: Text(
                'Sign In',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
        ),
      );

  Widget buildButtonSignUp() => Center(
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 10.0),
          width: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: FlatButton(
              color: Colors.red[700],
              onPressed: () {
                Navigator.pop(context);
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (value) => Register());
                Navigator.push(context, route);
              },
              child: Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
        ),
      );

  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            onChanged: (String string) {
              email = string.trim();
              id = email;
            },
            decoration: InputDecoration.collapsed(hintText: "Email"),
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldPassword() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            onChanged: (value) => password = value.trim(),
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "Password"),
            style: TextStyle(fontSize: 18)));
  }

  Future<void> checkEmail() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((response) {
      //print('Authen Success');
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }).catchError((response) {
      normalDialog(context, 'ไม่ข้อมูลในระบบ');
    });
  }
}

Future<void> normalDialog(BuildContext context, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(message),
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Ok'),
            ),
          ],
        ),
      ],
    ),
  );
}

mySizebox1() => SizedBox(
      width: 8.0,
      height: 20.0,
    );
