import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email, password, cpassword;
  final formkey = GlobalKey<FormState>();
  final database = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[400],
      appBar: AppBar(
        title: Text('MEMORY TODAY APP', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              MaterialPageRoute route =
                  MaterialPageRoute(builder: (value) => LoginPage());
              Navigator.push(context, route);
            },
          ),
        ],
      ),
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
                    showtext(),
                    mySizebox(),
                    buildTextFieldEmail(),
                    buildTextFieldPassword(),
                    buildTextFieldconPassword(),
                    Text('______________________________________'),
                    buildButtonSignUp(),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Text showtext() => Text(
        'Register',
        style: TextStyle(
          fontSize: 28,
          color: Color(0xFF262d43),
        ),
      );

  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            onChanged: (value) => email = value.trim(),
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

  Container buildTextFieldconPassword() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            onChanged: (value) => cpassword = value.trim(),
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "Confirm Password"),
            style: TextStyle(fontSize: 18)));
  }

  mySizebox() => SizedBox(
        width: 8.0,
        height: 20.0,
      );

  Widget buildButtonSignUp() => Center(
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 16.0),
          width: 200,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: FlatButton(
              color: Colors.red[700],
              onPressed: () {
                if (email == null ||
                    email.isEmpty ||
                    password == null ||
                    password.isEmpty ||
                    cpassword == null ||
                    cpassword.isEmpty) {
                  normalDialog(context, 'กรุณากรอกข้อมูลให้ครบ');
                } else if (password != cpassword || cpassword != password) {
                  normalDialog(context, 'รหัสไม่ตรงกัน กรุณากรอกใหม่');
                } else if (password.length < 6) {
                  normalDialog(context, 'รหัสต้องมีมากกว่า 6 หลัก');
                } else {
                  regis();
                  MaterialPageRoute materialPageRoute = MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage());
                  Navigator.of(context).pushAndRemoveUntil(
                      materialPageRoute, (Route<dynamic> route) => false);
                }
              },
              child: Text(
                'Enter',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
          ),
        ),
      );

  Future<Null> regis() async {
    var root = database.child("user");
    root.child(email).set({
      'password': password,
      'confirm': cpassword,
      'Name': "",
      'PathImage': "",
      'Detail':"",
    });
    //   MaterialPageRoute route = MaterialPageRoute(
    //     builder: (context) => Login(),
    //   );
    //   Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
//Future<void> setupDisplayName() async {
//FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//await firebaseAuth.currentUser
//}
//}
