 import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:team_gp/Model/category.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team_gp/Screens/Services/categ.dart';
import 'package:path/path.dart' as p;
import 'package:team_gp/Screens/Widget/button.dart';

class EditCategory extends StatefulWidget {
  static String id = 'Edit Product';

  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final _store = Store();

  String _imageURL;

  String _name;

  File _image;

  @override
  Widget _showImage(){
      return CircleAvatar(
            backgroundImage: _image == null ? null : FileImage(_image),
            backgroundColor: Colors.red[100],
            radius: 60,
child: GestureDetector(onTap: takeImage,
    child: Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(80),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.transparent,
            border: Border.all(
                width: 1,
                color: Colors.transparent
            )
        ),
        child: Icon(Icons.add_photo_alternate_rounded, color: Colors.red[700], size: 40,))),
          );
    }

  @override
  Widget build(BuildContext context) {
    Category category = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red[100],
        title: Text("EDIT CATEGORIES",
            style: TextStyle(color: Colors.black, fontSize: 16.5)),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.red[700],
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        padding: EdgeInsets.only(
                left: 70,
                right: 70,),
        child: Center(
          child: Form(
            key: _formkey,
            autovalidate: true,
            child: ListView(
              children: [
               /*  SizedBox(
                  height: MediaQuery.of(context).size.height * .2,
                ), */
                Column(
                  mainAxisSize: MainAxisSize.min,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    _showImage(),
                    SizedBox(
                      height: 50.0,
                    ),
                    //دا البوتن اللي بنجيب منه الصورة من الجالري
                    Container(
                          child: TextFormField(
                            validator: (String value){
                                if(value.isEmpty){
                                return 'Name is required';}
                                return null;
                            },
                            onSaved: (String value)
                            {
                              _name = value;
                            },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.9),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  )
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  )
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  )
                                ),
                                suffixIcon: GestureDetector(onTap:() { uploadImage(context);},
                                    child: Container(
                                        margin: EdgeInsets.all(0),
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: Colors.transparent,
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.transparent
                                            )
                                        ),
                                        child: Icon(Icons.edit_attributes_sharp , color: Colors.red[700], size: 30,))),
                                labelText: "Categoty Name",
                              ),
                              keyboardType: TextInputType.text,
                            ),
                        ),
                    // كدا الفيلد خلص
                    SizedBox(height: 80.0),
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
                          _store.editCategory(
                              ({
                                'name': _name,
                                'image': _imageURL,
                              }),
                              category.id);
                        }
                      },
                      text: Text(
                        "Add",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      icon: Icon(Icons.add,size: 15,color: Colors.white,),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void takeImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

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
      //String url = link.toString();
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
}