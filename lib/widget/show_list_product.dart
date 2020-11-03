import 'package:appfrong/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class ShowListProduct extends StatefulWidget {
  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {
  List<ProductModel> productModels = List();

  final firebaseDatabase = FirebaseDatabase.instance;
  Query _ref;
  String img, name, detail;

  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('user')
        .orderByChild('PathImage');
  }
  Widget _buildContactItem({Map contact}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(5),
      height: 200,
        color: Color(0xFF262d43),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 10,
          ),
          Image.network(contact['PathImage'],
              width: 220, height: 150, fit: BoxFit.fill),
          Text(
             contact['Name'],
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          Text(
             contact['Detail'],
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF9fabb3),
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: _ref,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int dex) {
            Map contact = snapshot.value;
            return _buildContactItem(contact: contact);
          },
        ),
    );
  }
}
