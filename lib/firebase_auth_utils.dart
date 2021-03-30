import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hsms/signin_signup_page.dart';

abstract class AuthFunc{
  Future<List> signIn(String email, String password);
  Future<String> signUp(String email, String password, String type);
  Future<User> getCurrentUser();
  Future<void> sendEmailVerification();
  Future<void> signOut();
  Future<bool> emailVerified();
}

class MyAuth implements AuthFunc{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> getCurrentUser() async {
    return await _firebaseAuth.currentUser;
  }

  @override
  Future<bool> emailVerified() async{
    var user = await _firebaseAuth.currentUser;
    return user.emailVerified;
  }

  @override
  Future<void> sendEmailVerification() async{
    var user = await _firebaseAuth.currentUser;
    user.sendEmailVerification();
  }

  @override
  Future<List> signIn(String email, String password) async {
    var user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    var data =
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.email)
        .get();
    return [user.uid, data.data()["type"]];
  }

  @override
  Future<String> signUp(String email, String password, String type) async{
      var user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.email)
          .set({
        "uid": user.uid,
        "emailID": user.email,
        "type": type,
        "name": "",
        "contact": "",
        "address": "",
        "url": "https://firebasestorage.googleapis.com/v0/b/hsms-9724a.appspot.com/o/download.png?alt=media&token=75110cae-528a-4fcd-a786-6dab2d4138c4"
      });
      return user.uid;
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

}