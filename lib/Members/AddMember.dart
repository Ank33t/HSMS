import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hsms/Complaints/Complaints.dart';

import 'Member.dart';

class AddMember extends StatelessWidget {

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
      home: AddMemberState(title: 'Flutter Demo Home Page'),
    );
  }
}

class AddMemberState extends StatefulWidget {
  final String title;
  AddMemberState({Key key, this.title}) : super(key: key);
  @override
  _AddMemberStateState createState() => _AddMemberStateState();
}

class _AddMemberStateState extends State<AddMemberState> {
  Member m1 = Member("", "", "", "", "", "", "", "");


bool a =false;

  void saveMember()
  {
    setState(() {

    });
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    HashMap<String,Object> mp = new HashMap();
    mp[m1.flat] = m1;
    ref.child("Members").child(m1.flat).set(m1.toJson());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add/Update a Member"),),
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
                onChanged: (text){m1.flat=text;},
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
                onChanged: (text){m1.bhk=text;},
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type of Flat",
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
                onChanged: (text){m1.name=text;},
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Name",
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
                onChanged: (text){m1.previousowner=text;},
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Previous Owner",
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
                onChanged: (text){m1.dateofentry=text;},
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Date of Entry",
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
                onChanged: (text){m1.dateofpurchase=text;},
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Date of Purchase",
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
                onChanged: (text){m1.contact=text;},
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Contact",
                    hintStyle:
                    TextStyle(color: Colors.grey)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          Row(
            children: <Widget>[
              Text("   Activate Billing: "),
              Radio(value: true, groupValue: a, onChanged: (value)
              {
                setState(() {
                  a =true;
                });
                m1.activate=value.toString();
              })
            ],
          ),
            Row(
              children: <Widget>[
                Text(""),
              ],
            ),
          RaisedButton(onPressed: saveMember,
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.lightBlue,
            child: Text("Add Member"),)
        ],
      ),
    )



    );
  }
}
