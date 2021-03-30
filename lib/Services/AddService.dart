import 'dart:collection';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hsms/Complaints/Complaints.dart';
import 'package:image_picker/image_picker.dart';

import 'Service.dart';

class AddService extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AddServiceState(title: 'Flutter Demo Home Page'),
    );
  }
}

class AddServiceState extends StatefulWidget {
  final String title;
  AddServiceState({Key key, this.title}) : super(key: key);
  @override
  _AddServiceStateState createState() => _AddServiceStateState();
}

class _AddServiceStateState extends State<AddServiceState> {
  Service s1 = Service("", "", "", "", "");


  bool a =false;

  void saveService() async {
    var image1 = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 300);
    if (image1 != null) {
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('Profile-Pictures')
          .child(FirebaseAuth.instance.currentUser.email + '-profilepic');
      UploadTask uploadTask =
      firebaseStorageRef.putFile(File(image1.path));
      print('aaa');
      print(uploadTask);
      var imageUrl = await (await uploadTask).ref.getDownloadURL();
      print(imageUrl.toString());
      setState(() {});
      DatabaseReference ref = FirebaseDatabase.instance.reference();
      HashMap<String, Object> sp = new HashMap();
      sp[s1.name] = s1;
      s1.url = imageUrl.toString();
      ref.child("Services").child(s1.name).set(s1.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add a Service"),),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child:
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius:
                    BorderRadius.circular(15.0)),
                child: TextField(
                  onChanged: (text){s1.name=text;},
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Name: ",
                      hintStyle:
                      TextStyle(color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius:
                    BorderRadius.circular(15.0)),
                child: TextField(
                  onChanged: (text){s1.service=text;},
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Service: ",
                      hintStyle:
                      TextStyle(color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius:
                    BorderRadius.circular(15.0)),
                child: TextField(
                  onChanged: (text){s1.address=text;},
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Address: ",
                      hintStyle:
                      TextStyle(color: Colors.grey)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius:
                    BorderRadius.circular(15.0)),
                child: TextField(
                  onChanged: (text){s1.contact=text;},
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Contact: ",
                      hintStyle:
                      TextStyle(color: Colors.grey)),
                ),
              ),
              Row(
                children: <Widget>[
                  Text(""),
                ],
              ),
              RaisedButton(onPressed: saveService,
                elevation: 5.0,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                color: Colors.lightBlue,
                child: Text("Add Service"),)
            ],
          ),
        )
    );
  }
}
