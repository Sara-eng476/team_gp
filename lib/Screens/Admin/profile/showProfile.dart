import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team_gp/Model/profile.dart';
import 'package:path/path.dart' as p;
import 'package:team_gp/Screens/Services/profile.dart';

import 'changeProfileImage.dart';

class ShowProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Show",
      home: EditProfilePage(),
    );
  }
}

// ignore: must_be_immutable
class EditProfilePage extends StatefulWidget {
  AdminProfile admin;

  @override
  Widget _showImage() {
    return CircleAvatar(
      backgroundImage: _image == null ? null : FileImage(_image),
      backgroundColor: Colors.blueGrey[100],
      radius: 60,
    );
  }

  Widget _getDAta() {}

  _EditProfilePageState createState() => _EditProfilePageState();
}

final _admin = Admin();
String _imageURL =
    "https://cdn2.vectorstock.com/i/thumb-large/34/96/flat-business-man-user-profile-avatar-in-suit-vector-4333496.jpg";
File _image;

class _EditProfilePageState extends State<EditProfilePage> {
  String _name;
  User user = FirebaseAuth.instance.currentUser;
  final _adminProfile = AdminProfile();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Show Profile",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(_imageURL))),
                      // image: NetworkImage(user.photoURL)
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.blueAccent,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.camera_enhance),
                          color: Colors.white,
                          onPressed: () {
                            _showChoiceDialog(context);
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 90,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.blueAccent,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.update),
                          color: Colors.white,
                          onPressed: () {
                            uploadImage(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("Full Name", user.displayName, false),
              buildTextField("E-mail", user.email, false),
              buildTextField("Password", _imageURL, true),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {},
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {},
                    color: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice!"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

/*
  void pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image as File;
    });
  }
  void takeImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image as File;
    });
  }
*/
  _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      _image = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      _image = picture;
    });
    Navigator.of(context).pop();
  }

  Widget _decideImageView() {
    if (_image != null) {
      return Image.file(
        _image,
        width: 400,
        height: 200,
      );
    } else {
      return Text("No Image Selected!");
    }
  }

  void uploadImage(context) async {
    try {
      FirebaseStorage storage =
          FirebaseStorage.instanceFor(bucket: 'gs://review-77112.appspot.com');

      Reference ref = storage.ref().child(p.basename(_image.path));
      UploadTask storageUploadTask = ref.putFile(_image);
      TaskSnapshot taskSnapshot = await (await storageUploadTask);
      String url = await taskSnapshot.ref.getDownloadURL();
      _imageURL = url;
      user.updateProfile(photoURL: url);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('success'),
      ));
      // String link = await ref.getDownloadURL();
      // String url = link.toString();
      print('url $url');
      setState(() {
        user.updateProfile(photoURL: url);
      });
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }
  /*void uploadImage(context) async {
    try {
      FirebaseStorage storage =
          FirebaseStorage.instanceFor(bucket: 'gs://review-77112.appspot.com');
      Reference ref = storage.ref().child(p.basename(_image.path));
      UploadTask storageUploadTask = ref.putFile(_image);
      TaskSnapshot taskSnapshot =
          await storageUploadTask.whenComplete(() => null);
      /*Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('success'),
      ));*/
      String url = await taskSnapshot.ref.getDownloadURL();
      //String url = link.toString();
      print('url $url');
      _imageURL = url;
      user.updateProfile(photoURL: url);
      setState(() {
        _imageURL = url;
      });
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }
  */
}