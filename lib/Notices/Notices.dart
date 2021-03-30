import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';


class Notices extends StatefulWidget {

  String userType;

  Notices({Key key, this.userType = "default"}):super(key:key);

  @override
  _NoticesState createState() => _NoticesState();
}

class _NoticesState extends State<Notices> {


  List<String> list =[];
  final HashMap<String,String> map = new HashMap<String,String>();
  void getNotice()
  {
    // list.add("Ankeet");
    // list.add("Manav");
    // map[list[0]] = C";
    // map[list[1]] = "Notice1";
    list.clear();
    map.clear();
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child("Notices").once().then((DataSnapshot datasnapshot){
      var values = datasnapshot.value;
      var keys = datasnapshot.value.keys;
      for(var key in keys)
      {
        list.add(key);
        map[key] = values[key];
      }
      setState(() {
        //
      });
    });
    // map["702"] = "There has been an issue of the cleaning staff not working properly. Please look into it";

  }

  createAlertDialog(BuildContext context)
  {
    TextEditingController controller = new TextEditingController();
    TextEditingController controller1 = new TextEditingController();
    TextEditingController controller2 = new TextEditingController();

    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Add Notice"),
        content: SingleChildScrollView(
          // height: 270,
          child: Column(
              children: <Widget>[

                TextField(
                  onChanged: (text){
                    // list.add(text);
                  },
                  controller: controller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Subject'
                  ),
                ),
                TextField(
                  onChanged: (text){
                    // map[list[2]]=text;
                  },
                  controller: controller1,
                  maxLines: 10,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Notice Details'
                  ),
                ),
                RaisedButton(onPressed: (){
                  setState(() {
                    // list.add(controller.text);
                    // map[list[2]]=controller1.text;
                    DatabaseReference ref1 = FirebaseDatabase.instance.reference().child("Notices");
                    ref1.child(controller.text).set(controller1.text);
                    setState(() {
                      getNotice();
                    });
                  });
                  Navigator.of(context).pop();
                }, child: Text("Add"))
              ]
          ),),
      );
    });
  }

  void newNotice()
  {
    createAlertDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notices"),),
      body:

      ListView.builder(itemBuilder: (context,index){

        return Card(
          color: Colors.lightBlue[50],
          child: ListTile(
            title: Text(list[index],style: TextStyle(fontSize: 20.0,),),
            subtitle: Text(map[list[index]], style: TextStyle(fontSize: 18.0,),),
            trailing: widget.userType == "Admin"?
            IconButton(
              icon:
              Icon(Icons.delete,),
              iconSize: 25,
              color: Colors.red,
              splashColor: Colors.grey,
              onPressed: () {
                deleteNotice(list[index]);
                getNotice();
                setState(() {});},
            ) : SizedBox(height: 0,)
          ),
        );
      },itemCount: list.length,),
      floatingActionButton: widget.userType == "Admin"?
      FloatingActionButton(
        onPressed: newNotice,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ) : SizedBox(height: 0,)
    );
  }

  _NoticesState()
  {
    getNotice();
  }
}

deleteNotice(String key)
{
  DatabaseReference ref1 = FirebaseDatabase.instance.reference().child("Notices");
  ref1.child(key).set(null);
}
