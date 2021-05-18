import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:team_gp/Model/category.dart';
import 'package:team_gp/Model/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team_gp/Screens/Services/pro.dart';
import 'package:path/path.dart' as p;
import 'package:team_gp/Screens/Widget/button.dart';

class CustomDialog extends StatefulWidget {
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final _store = Store();
  String _imageURL;
  String _name;
  File _image;
  var selectedCurrency;
  
  CollectionReference snapshotcategory = FirebaseFirestore.instance.collection('Category');
  List<Category> listcategories =[];



  @override
  Widget _showImage() {
    return CircleAvatar(
      backgroundImage: _image == null ? null : FileImage(_image),
      backgroundColor: Colors.blueGrey[100],
      radius: 60,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 60.0,
            ),
            margin: EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                autovalidate: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _showImage(),
                    SizedBox(
                      height: 10.0,
                    ),
                    //دا البوتن اللي بنجيب منه الصورة من الجالري
                    GestureDetector(
                        onTap: takeImage,
                        child: Container(
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue[50],
                                border: Border.all(
                                    width: 1, color: Colors.blueGrey[200])),
                            child: Icon(
                              Icons.add_photo_alternate_rounded,
                              color: Colors.blueGrey[500],
                              size: 30,
                            ))),
                    // دا البوتن اللي بيضيف الصورة
                    GestureDetector(
                        onTap: () {
                          uploadImage(context);
                        },
                        child: Container(
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue[50],
                                border: Border.all(
                                    width: 1, color: Colors.blueGrey[200])),
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.blueGrey[500],
                              size: 30,
                            ))),
                    SizedBox(
                      height: 10,
                    ),
                    // التيكست فيلد بتاع الاسم
                    TextFormField(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        _name = value;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: Colors.blueGrey[200],
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: Colors.blueGrey[200],
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide(
                              color: Colors.blueGrey[200],
                            )),
                        labelText: "Name",
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    // كدا الفيلد خلص
                    SizedBox(height: 5.0),
                    //
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Category"),
                          SizedBox(width:10),
                          Expanded(
                              child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Not Selected",
                              ),
                            ),
                          ),
                          IconButton(icon: Icon(
                            Icons.edit_attributes_outlined,
                          ), onPressed: null)
                      ],),
                    ),

                    // البوتن
                    GradientButton(
                      width: 109,
                      height: 50,
                      onPressed: () {
                        uploadImage(context);
                        if (_formkey.currentState.validate()) {
                          //  uploadImage(context);
                          _formkey.currentState.save();
                          //_formkey.currentState.reset();
                          _store.addProduct(Product(
                            name: _name,
                            image: _imageURL,
                          ));
                        }
                      },
                      text: Text(
                        "Add",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        textAlign: TextAlign.center,
                      ),
                      icon: Icon(null),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // close دا ال
          Positioned(
            right: 0.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: Colors.red[400],
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // دي كنت عملاها بتاخد الصورة من الكاميرا زوديها لو عايزاا بس حسيت المكان هيبقي زحمة
  void pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  } // الفانكشن خلصت هنا

  // دي الفانكشن اللي بتفتح الصرو من الجالري
  void takeImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

/////// الفانكشن اللي بتخزن الصور في الستوردج
  void uploadImage(context) async {
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
      print('url $url');
      setState(() {
        _imageURL = url;
      });
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }
// الفانكشن خلصت هنا
}
