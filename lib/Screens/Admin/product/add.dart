import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team_gp/Model/product.dart';
import 'package:team_gp/Screens/Admin/product/view.dart';
import 'package:team_gp/Screens/Services/pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart' as p;

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var selectedCategory, selectedType;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  String categoryName;
  final _store = Store();
  String _imageURL;
  String _name;
  String _id;

  File _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                FontAwesomeIcons.bars,
                color: Colors.white,
              ),
              onPressed: () {}),
          title: Container(
            alignment: Alignment.center,
            child: Text("ADD PRODUCT",
                style: TextStyle(
                  color: Colors.white,
                )),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.store,
                  size: 20.0,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ViewProduct()));
                }),
          ],
        ),
        body: Form(
          key: _formKeyValue,
          autovalidate: true,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
              SizedBox(height: 20.0),
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

              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Category")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data.docs[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(snap.get('name'),
                                style: TextStyle(color: Colors.black)),
                            value: snap.id,
                          ),
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.category_outlined,
                              size: 25.0, color: Colors.black),
                          SizedBox(width: 50.0),
                          DropdownButton(
                            items: currencyItems,
                            onChanged: (categoryValue) {
                              final snackBar = SnackBar(
                                content: Text(
                                  'Selected type of Category is $categoryValue',
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedCategory = categoryValue;
                              });
                            },
                            value: selectedCategory,
                            isExpanded: false,
                            hint: new Text(
                              "Choose Category Type",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
              SizedBox(
                height: 150.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                      color: Colors.indigoAccent[100],
                      textColor: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("ADD PRODUCT",
                                  style: TextStyle(fontSize: 24.0)),
                            ],
                          )),
                      onPressed: () {
                        uploadImage(context);
                        if (_formKeyValue.currentState.validate()) {
                          //  uploadImage(context);
                          _formKeyValue.currentState.save();
                          //_formkey.currentState.reset();
                          _store.addProduct(Product(
                            id: selectedCategory,
                            name: _name,
                            image: _imageURL,
                            category: selectedCategory,
                            createdAt: DateTime.now().toString(),
                          ));
                        }
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ViewProduct()));
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))),
                ],
              ),
            ],
          ),
        ));
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

  @override
  Widget _showImage() {
    return CircleAvatar(
      backgroundImage: _image == null ? null : FileImage(_image),
      backgroundColor: Colors.blueGrey[100],
      radius: 60,
    );
  }
}