import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hsms/signin_signup_page.dart';
import 'admin_homepage.dart';
import 'firebase_auth_utils.dart';
import 'home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Housing Society Management System",
      home: new MyAppHome(auth: new MyAuth()),
    );
  }
}
//hey

class MyAppHome extends StatefulWidget{
  MyAppHome({this.auth});
  AuthFunc auth;

  @override
  State<StatefulWidget> createState() => new _MyAppHomeState();
}

enum AuthStatus{
  NOT_LOGIN,
  NOT_DETERMINED,
  LOGIN
}

class _MyAppHomeState extends State<MyAppHome>{
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "", _userEmail = "", _userType = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setType();
  }

  void setType() async{
    await widget.auth.getCurrentUser().then((user) async
    {
      var data =
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.email)
          .get();
      setState(() {
        if(user != null){
          _userId = user?.uid;
          _userEmail = user?.email;
          _userType = data.data()["type"];
        }
        authStatus = user?.uid == null ? AuthStatus.NOT_LOGIN : AuthStatus.LOGIN;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    switch (authStatus) {
      //case AuthStatus.NOT_DETERMINED:
       // return _showLoading();
        //break;
      case AuthStatus.NOT_LOGIN:
        return  new SignInSignUpPage(auth: widget.auth, onSignedIn: _onSignedIn);
        break;
      case AuthStatus.LOGIN:
        if(_userId.length > 0 && _userId != null)
          if(_userType == "Member") {
            return new HomePage(
                userId: _userId,
                userEmail: _userEmail,
                userType: _userType,
                auth: widget.auth,
                onSignOut: _onSignOut
            );
          }
        else{
            return new AdminHomePage(
                userId: _userId,
                userEmail: _userEmail,
                userType: _userType,
                auth: widget.auth,
                onSignOut: _onSignOut
            );
          }
        else
          return _showLoading();
        break;
      default:
        return  new SignInSignUpPage(auth: widget.auth, onSignedIn: _onSignedIn);
        break;
    }
  }

  void _onSignOut(){
    setState(() {
      authStatus = AuthStatus.NOT_LOGIN;
      _userId = _userEmail = "";
    });
  }

  void _onSignedIn(){
    widget.auth.getCurrentUser().then((user) async{
      var data =
          await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.email)
          .get();
      print(data.data());
      setState(() {
        _userId = user.uid.toString();
        _userEmail = user.email.toString();
        _userType = data.data()["type"];
      });
      setState(() {
        authStatus = AuthStatus.LOGIN;
      });
    });
  }
}

Widget _showLoading() {
  return Scaffold(body: Container(
    alignment: Alignment.center, child: CircularProgressIndicator(),),);
}