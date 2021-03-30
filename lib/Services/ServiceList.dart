import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'AddService.dart';
import 'Service.dart';
import 'ServiceDetails.dart';

class ServiceApp extends StatefulWidget {

  @override
  _ServiceAppState createState() => _ServiceAppState();
}

class _ServiceAppState extends State<ServiceApp> {

  Service n;
  List<Service> mlist=[];
  List<String> list =[];
  final HashMap<String,String> map = new HashMap<String,String>();
  _ServiceAppState()
  {
    //
    getServices();
    // setState(() {
    //
    // });

  }

  void getServices()
  {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child("Services").once().then((DataSnapshot datasnapshot){
      list.clear();
      var keys = datasnapshot.value.keys;
      var values = datasnapshot.value;
      for(var key in keys)
      {
        list.add(key.toString());
        Service s = new Service(
            values[key]["name"].toString(),
            values[key]["service"],
            values[key]["address"],
            values[key]["contact"],
            values[key]["url"],);
        // return m;
        mlist.add(s);
      }
      setState(() {
        //
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Services")),
      body:
      ListView.builder(itemBuilder: (context,index){
        return Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: Colors.lightBlue[50],
          child: ListTile(
            onTap: (){
              Navigator.push(context,  MaterialPageRoute(builder: (context) => ServiceDetails(mlist[index])));} ,
            title: Text(list[index], style: TextStyle(fontSize: 20.0,),),
            subtitle: Text("Service: " + mlist[index].service, style: TextStyle(fontSize: 18.0,),),
          ),
        );
      },itemCount: list.length,),
      floatingActionButton: FloatingActionButton(
        onPressed: (){Navigator.push(context,
          MaterialPageRoute(builder: (context) => AddService()),
        );},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}


