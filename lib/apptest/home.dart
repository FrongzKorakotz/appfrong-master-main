import 'package:appfrong/apptest/login.dart';
import 'package:appfrong/widget/add_list_product.dart';
import 'package:appfrong/widget/show_list_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
  Home({Key key, this.title}) : super(key: key);
  final String title;
}

class _HomeState extends State<Home> {
  String login = '...';
  Widget currentWidget = ShowListProduct();

  //  @override
  //  void initState() {
  //    super.initState();
  //    findDisplayName();
  //  }

  Widget showListProduct() {
    return ListTile(
      leading: Icon(
        Icons.list,
        size: 36.0,
        color: Colors.purple,
      ),
      title: Text('List Product'),
      subtitle: Text('Show all List Product'),
      onTap: () {
        setState(() {
          currentWidget = ShowListProduct();
        });
        Navigator.of(context).pop();
      },
    );
  }

  Widget showAddList() {
    return ListTile(
      leading: Icon(
        Icons.playlist_add,
        size: 36.0,
        color: Colors.green[400],
      ),
      title: Text('Add List Product'),
      subtitle: Text('Add New Product to Database'),
      onTap: () {
        setState(() {
          currentWidget = AddListProduct();
        });
        Navigator.of(context).pop();
      },
    );
  }

//    Future<void> findDisplayName() async {
//      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//      FirebaseUser firebaseUser =
//          await firebaseAuth.
//      setState(() {
//        login = firebaseUser.displayName;
//      });
//      print('login = $LoginPage()');
//    }

  Widget showLogin() {
    return Text(
      'Login by $login',
      style: TextStyle(color: Colors.white),
    );
  }

  Widget showAppName() {
    return Text(
      'Memory Today App',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 80.0,
      height: 80.0,
      child: Image.asset('images/logoo.png'),
    );
  }

  Widget showHead() {
    return DrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/head.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          showLogo(),
          SizedBox(
            height: 10.0,
          ),
          showAppName(),
          SizedBox(
            height: 10.0,
          ),
          showLogin(),
        ],
      ),
    );
  }

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          showHead(),
          showListProduct(),
          showAddList(),
        ],
      ),
    );
  }

  Widget signOutButton() {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Sign Out',
      onPressed: () {
        myAlret();
      },
    );
  }

  void myAlret() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are You Sure ?'),
            content: Text('Do You Want Sign Out ?'),
            actions: <Widget>[
              cancelButton(),
              okButton(),
            ],
          );
        });
  }

  Widget okButton() {
    return FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
        processSignOut();
      },
    );
  }

  Future<void> processSignOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => LoginPage());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  Widget cancelButton() {
    return FlatButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MEMORY TODAY APP'),
        actions: <Widget>[signOutButton()],
      ),
      body: currentWidget,
      drawer: showDrawer(),
    );
  }
}
