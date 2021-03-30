import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'AddMember.dart';
import 'Member.dart';
import 'MemberDetails.dart';

class MemberApp extends StatefulWidget {

  @override
  _MemberAppState createState() => _MemberAppState();
}

class _MemberAppState extends State<MemberApp> {

  Member n;
  List<Member> mlist=[];
  List<String> list =[];
  final HashMap<String,String> map = new HashMap<String,String>();
  _MemberAppState()
  {
    //
    getMembers();
    // setState(() {
    //
    // });

  }

  void getMembers()
  {
     DatabaseReference ref = FirebaseDatabase.instance.reference();
     ref.child("Members").once().then((DataSnapshot datasnapshot){
      list.clear();
      var keys = datasnapshot.value.keys;
      var values = datasnapshot.value;
      for(var key in keys)
        {
          list.add(key.toString());
          Member m = new Member(
              values[key]["activate"].toString(),
              values[key]["bhk"],
              values[key]["contact"],
              values[key]["dateofentry"],
              values[key]["dateofpurchase"],
              values[key]["flat"],
              values[key]["name"],
              values[key]["previousowner"]);
          // return m;
          mlist.add(m);
        }
      setState(() {
        //
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Members")),
      body:
      ListView.builder(itemBuilder: (context,index){
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: Colors.lightBlue[50],
         child: ListTile(
           onTap: (){
             Navigator.push(context,  MaterialPageRoute(builder: (context) => MemberDetails(mlist[index])));} ,
           title: Text(list[index], style: TextStyle(fontSize: 20.0,),),
           subtitle: Text("Name: " + mlist[index].name, style: TextStyle(fontSize: 18.0,),),
         ),
        );
      },itemCount: list.length,),
      floatingActionButton: FloatingActionButton(
      onPressed: (){Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddMember()),
      );},
      tooltip: 'Increment',
      child: Icon(Icons.add),
    ),
    );
  }
}


