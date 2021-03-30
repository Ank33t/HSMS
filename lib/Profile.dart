import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController flatController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  String url = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    var user = FirebaseAuth.instance.currentUser;
    var data =
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.email)
        .get();
    // DocumentSnapshot doc = await usersRef.document(widget.currentUserId).get();
    // user = User.fromDocument(doc);
    displayNameController.text = data.data()["name"];
    contactController.text = data.data()["contact"];
    flatController.text = data.data()["address"];

    setState(() {
      url = data.data()["url"];
      isLoading = false;
    });
  }

  Column buildDisplayNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Name",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: displayNameController,
          decoration: InputDecoration(
            hintText: "Enter Name",
          ),
        )
      ],
    );
  }

  Column buildContactField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Contact",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: contactController,
          decoration: InputDecoration(
            hintText: "Enter Mobile No.",
          ),
        )
      ],
    );
  }

  Column buildFlatField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Address",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: flatController,
          decoration: InputDecoration(
            hintText: "Enter Address",
          ),
        )
      ],
    );
  }

  updateProfileData() async{
    setState(() {
      FocusScope.of(context).requestFocus(new FocusNode());
    });
    var user = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.email)
        .update(
          {
            "name": displayNameController.text,
            "contact": contactController.text,
            "address" : flatController.text,
          }
        );
      SnackBar snackbar = SnackBar(content: Text("Profile updated!"));
      _scaffoldKey.currentState.showSnackBar(snackbar);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.done,
              size: 30.0,
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: isLoading
          ? Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 10.0),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.purple),
          ))
          : ListView(
        children: <Widget>[
          SizedBox(height : 10),
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 16.0,
                    bottom: 8.0,
                  ),
                  child: CircleAvatar(
                    radius: 70.0,
                    backgroundImage:
                    NetworkImage(url),

                  ),

                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: FlatButton.icon(
                    onPressed: () async{
                      var image1 = await ImagePicker()
                        .getImage(source: ImageSource.gallery, maxHeight: 300);
                      if (image1 != null){
                        Reference firebaseStorageRef = FirebaseStorage.instance
                            .ref()
                            .child('Profile-Pictures')
                            .child(FirebaseAuth.instance.currentUser.email + '-profilepic');
                        UploadTask uploadTask =
                        firebaseStorageRef.putFile(File(image1.path));
                        print('aaa');
                        print(uploadTask);
                        var imageUrl = await (await uploadTask).ref.getDownloadURL();
                        setState(() {
                          url = imageUrl.toString();
                        });
                        print(url);
                        var user = FirebaseAuth.instance.currentUser;
                        await FirebaseFirestore.instance
                            .collection('Users')
                            .doc(user.email)
                            .update(
                            {
                              "url": url,
                            }
                        );
                        SnackBar snackbar = SnackBar(content: Text("Profile Image updated!"));
                        _scaffoldKey.currentState.showSnackBar(snackbar);
                      }
                      },
                    icon: Icon(Icons.cloud_upload, color: Colors.cyan),
                    label: Text(
                      "Upload New Image",
                      style: TextStyle(color: Colors.cyan, fontSize: 15.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 12.0),
                        child: Text(
                          "Email",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: FirebaseAuth.instance.currentUser.email,
                        ),
                      )
                    ],
                  ),
                      SizedBox(
                        height: 10,
                      ),
                      buildDisplayNameField(),
                      SizedBox(
                        height: 10,
                      ),
                      buildContactField(),
                      SizedBox(
                        height: 10,
                      ),
                      buildFlatField(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  onPressed: updateProfileData,
                  child: Text(
                    "Update Profile",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}