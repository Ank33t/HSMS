import 'package:hsms/firebase_auth_utils.dart';
import 'package:flutter/material.dart';

import 'Complaints/Complaints.dart';
import 'Notices/Notices.dart';
import 'Profile.dart';
import 'Services/ServiceList.dart';

class HomePage extends StatefulWidget{

  AuthFunc auth;
  VoidCallback onSignOut;
  String userId,userEmail, userType;

  HomePage({Key key, this.auth, this.onSignOut, this.userId, this.userEmail, this.userType = "default"}):super(key:key);

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _emailVerified = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text(widget.userType + 'Housing Society System'),
        actions: <Widget>[FlatButton(child: Text('SignOut', style: TextStyle(color: Colors.white)), onPressed: _signOut),
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('',style: TextStyle(fontSize: 20.0,)),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(onPressed: () {Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()),
                  );},
                  child: Image.asset(("images/profile1.jpg"), width: 160, height: 130,)),
                  FlatButton(onPressed: () {},
                      child: Image.asset(("images/visitors1.png"), width: 160, height: 130,)),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Profile', style: TextStyle(fontSize: 20.0,),),
                Text('Visitors',style: TextStyle(fontSize: 20.0,)),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('',style: TextStyle(fontSize: 20.0,)),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(onPressed: () {Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Notices(userType: widget.userType,)),
                  );},
                      child: Image.asset(("images/noticeboard.jpg"), width: 160, height: 130,)),
                  FlatButton(onPressed: () {},
                      child: Image.asset(("images/vehicles.png"), width: 160, height: 130,))
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Notices',style: TextStyle(fontSize: 20.0,)),
                  Text('Vehicles',style: TextStyle(fontSize: 20.0,)),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('',style: TextStyle(fontSize: 20.0,)),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(onPressed: () {},
                      child: Image.asset(("images/bill.jpg"), width: 160, height: 130,)),
                  FlatButton(onPressed: () {Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ServiceApp()),
                  );},
                      child: Image.asset(("images/services.png"), width: 160, height: 130,)),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Payments',style: TextStyle(fontSize: 20.0,)),
                  Text('Services',style: TextStyle(fontSize: 20.0,)),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('',style: TextStyle(fontSize: 20.0,)),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(onPressed: () {Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Complaints(userType: widget.userType,)),
                  );},
                      child: Image.asset(("images/complaints1.jpg"), width: 160, height: 130,)),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Complaints',style: TextStyle(fontSize: 20.0,)),
                ],
              ),
            ],
            ),
    );
  }

  void _checkEmailVerification() async {
    _emailVerified = await widget.auth.emailVerified();
    if(!_emailVerified)
      _showVerifyEmailDialog();
  }

  void _showVerifyEmailDialog() {
    showDialog(context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: new Text('Please verify your email'),
        content: new Text('We need you to verify your email to continue use this app'),
        actions: <Widget>[
          new FlatButton(onPressed: (){
            Navigator.of(context).pop();
            _sendVerifyEmail();
          }, child: Text('Send')),
          new FlatButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text('Dismiss'))
        ],
      );
    });
  }

  void _sendVerifyEmail() {
    widget.auth.sendEmailVerification();
    _showVerifyEmailSentDialog();
  }

  void _showVerifyEmailSentDialog() {
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: new Text('Thank you'),
            content: new Text('Verification link has been sent to your email'),
            actions: <Widget>[
              new FlatButton(onPressed: (){
                Navigator.of(context).pop();
              }, child: Text('OK'))
            ],
          );
        });
  }

  void _signOut() async{
    try{
      await widget.auth.signOut();
      widget.onSignOut();
    }catch(e){
      print(e);
    }
  }
}