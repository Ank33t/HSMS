import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Bill.dart';

class AddBills extends StatelessWidget {

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
      home: AddBillsState(title: 'Add Bills'),
    );
  }
}

class AddBillsState extends StatefulWidget {
  final String title;
  AddBillsState({Key key, this.title}) : super(key: key);
  @override
  _AddBillsStateState createState() => _AddBillsStateState();
}

class _AddBillsStateState extends State<AddBillsState> {
  // Bills b1 = Bills("", "", "", "", "");

  Bills b1 = new Bills("", "", "", "", "");

  bool a =false;

  void saveBills()
  {
    setState(() {});
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child("Bills").child(b1.client).set(b1.toJson());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add/Update a Bills"),),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("Date:"),
              Container(width: 100,child: TextField(onChanged: (text){b1.date=text;},))
            ],
          ),
          Row(
            children: <Widget>[
              Text("Detail:"),
              Container(width: 100,child: TextField(onChanged: (text){b1.detail=text;},))
            ],
          ),
          Row(
            children: <Widget>[
              Text("Description:"),
              Container(width: 100,child: TextField(onChanged: (text){b1.desc=text;},))
            ],
          ),
          Row(
            children: <Widget>[
              Text("Client"),
              Container(width: 100,child: TextField(onChanged: (text){b1.client=text;},))
            ],
          ),
          Row(
            children: <Widget>[
              Text("Price"),
              Container(width: 100,child: TextField(onChanged: (text){b1.price=text;},))
            ],
          ),
          RaisedButton(onPressed: saveBills,child: Text("Add"),)
        ],
      ),
    );
  }
}


