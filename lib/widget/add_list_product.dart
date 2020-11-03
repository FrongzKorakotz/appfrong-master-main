import 'dart:io';
import 'dart:math';
import 'package:appfrong/apptest/login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:appfrong/apptest/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddListProduct extends StatefulWidget {
  @override
  _AddListProductState createState() => _AddListProductState();
}

class _AddListProductState extends State<AddListProduct> {
  File file;
  String name, detail, urlPicture;
  final database = FirebaseDatabase.instance.reference();
  LoginPage d;
  Widget uploadButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton.icon(
            color: Colors.deepOrange,
            onPressed: () {
              print('You Click Upload');

              if (file == null) {
                shoeAlert(
                    'Non Choose Picture', 'Please Click Camera or Gallery');
              } else if (name == null ||
                  name.isEmpty ||
                  detail == null ||
                  detail.isEmpty) {
                shoeAlert('กรุณากรอกข้อมูลให้ครบ', '');
              } else if (file != null ||
                  name == null ||
                  name.isEmpty ||
                  detail == null ||
                  detail.isEmpty) {
                cond();
                // uploadPictureToStorage();
              }
            },
            icon: Icon(
              Icons.cloud_upload,
              color: Colors.black,
            ),
            label: Text(
              'UPLOAD DATA TO FIREBASE',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> uploadPictureToStorage() async {
    Random random = Random();
    int i = random.nextInt(10000);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    StorageReference storageReference =
        firebaseStorage.ref().child('Product/picture$i.jpg');
    StorageUploadTask storageUploadTask = storageReference.putFile(file);
    print(storageReference);
    urlPicture =
        await (await storageUploadTask.onComplete).ref.getDownloadURL();
    print('urlPicture = $urlPicture');
    regis();
  }

  Future<void> shoeAlert(String title, String message) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }

  Future<Null> regis() async {
    var root = database.child("user");
    root.child(id).update({
      'PathImage': urlPicture,
      'Name': name,
      'Detail': detail,
    });
    //   MaterialPageRoute route = MaterialPageRoute(
    //     builder: (context) => Login(),
    //   );
    //   Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget nameFrom() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextField(
        onChanged: (String string) {
          name = string.trim();
        },
        decoration: InputDecoration(
          helperText: 'What Your Name of Picture.',
          labelText: 'Name Picture',
          icon: Icon(Icons.face_retouching_natural),
        ),
      ),
    );
  }

  Widget detailFrom() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextField(
        onChanged: (value) {
          detail = value.trim();
        },
        decoration: InputDecoration(
          helperText: 'What Your Name of Picture.',
          labelText: 'Detail Picture.',
          icon: Icon(Icons.local_florist),
        ),
      ),
    );
  }

  Widget cameraButton() {
    return IconButton(
        icon: Icon(
          Icons.add_a_photo,
          size: 45.5,
          color: Color(0xFF262d43),
        ),
        onPressed: () {
          chooseImage(ImageSource.camera);
        });
  }

  Future<void> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );

      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Widget galleryButton() {
    return IconButton(
        icon: Icon(
          Icons.add_photo_alternate,
          size: 48.5,
          color: Color(0xFF262d43),
        ),
        onPressed: () {
          chooseImage(ImageSource.gallery);
        });
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        cameraButton(),
        galleryButton(),
      ],
    );
  }

  Widget showImage() {
    return Container(
      padding: EdgeInsets.all(20.0),
      //color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: file == null ? Image.asset('images/image.png') : Image.file(file),
    );
  }

  Widget showContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          showImage(),
          showButton(),
          nameFrom(),
          detailFrom(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            showContent(),
            uploadButton(),
          ],
        ));
  }

  Future<Null> cond() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('คุณได้ทำการอัพโหลดข้อมูลเรียบร้อยแล้ว'),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                onPressed: () {
                  uploadPictureToStorage();
                  MaterialPageRoute materialPageRoute = MaterialPageRoute(
                      builder: (BuildContext context) => Home());
                  Navigator.of(context).pushAndRemoveUntil(
                      materialPageRoute, (Route<dynamic> route) => false);
                },
                child: Text('รับทราบ'),
              )
            ],
          )
        ],
      ),
    );
  }


}
