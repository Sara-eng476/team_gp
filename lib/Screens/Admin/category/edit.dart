import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:team_gp/Model/category.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team_gp/Screens/Services/categ.dart';
import 'package:path/path.dart' as p;
import 'package:team_gp/Screens/Widget/button.dart'; 


class EditProduct extends StatefulWidget{
static String id = 'Edit Product';
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

    final _store = Store();

    String _imageURL;

    String _name;

    File _image;

    @override
    Widget _showImage(){
      return CircleAvatar(
            backgroundImage: _image == null ? null : FileImage(_image),
            backgroundColor: Colors.blueGrey[100],
            radius: 60,
          );
                          
    }

  @override 
  Widget build (BuildContext context)
  {
    Category category = ModalRoute.of(context).settings.arguments;
      return Scaffold(
        appBar: AppBar(
        elevation: 0,
        backgroundColor:Colors.blueGrey[500],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.blueGrey[50],
        body: Center(
          child: Form(
                      key : _formkey,
                      autovalidate: true,
                      child: ListView(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .2,
                          ),
                          Column(
                        mainAxisSize: MainAxisSize.min,
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text("Edit Category",
                           textAlign: TextAlign.center,
                           style: TextStyle(
                             fontSize: 30.0, color: Colors.blueGrey[800],
                             fontWeight: FontWeight.bold,
                             fontStyle: FontStyle.italic,shadows: [Shadow(blurRadius: 10.0,color: Colors.black54,
                             offset: Offset(5.0, 5.0),),
                             Shadow(color: Color(0xFFE0F7FA),blurRadius: 10.0,offset: Offset(-5.0, 5.0),)],
                             letterSpacing: -1.0,wordSpacing: 5.0,),),
                             SizedBox(
                               height: 50,
                             ),
                          _showImage(),
                            SizedBox(
                            height: 10.0,
                            ),
                            //دا البوتن اللي بنجيب منه الصورة من الجالري 
                            GestureDetector(onTap: takeImage, 
                            child: Container(
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue[50],
                                border: Border.all(
                                  width: 1,
                                  color: Colors.blueGrey[200]
                                )
                              ),
                              child: Icon(Icons.add_photo_alternate_rounded, color: Colors.blueGrey[500], size: 30,))),
                            // دا البوتن اللي بيضيف الصورة
                            GestureDetector(onTap:() { uploadImage(context);}, 
                            child: Container(
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.blue[50],
                                border: Border.all(
                                  width: 1,
                                  color: Colors.blueGrey[200]
                                )
                              ),
                              child: Icon(Icons.check_circle , color: Colors.blueGrey[500], size: 30,))),
                            SizedBox(height:10,),
                            // التيكست فيلد بتاع الاسم
                            TextFormField(
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
                                      color: Colors.blueGrey[200],
                                    )
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: BorderSide(
                                      color: Colors.blueGrey[200],
                                    )
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    borderSide: BorderSide(
                                      color: Colors.blueGrey[200],
                                    )
                                  ),
                                  labelText: "Name",
                                ),
                                keyboardType: TextInputType.text,
                              ),
                              // كدا الفيلد خلص
                            SizedBox(height: 15.0),
                              // البوتن
                            GradientButton(
                                  width: 109,
                                  height: 50,
                                  onPressed: () {
                                    uploadImage(context);
                                    if(_formkey.currentState.validate()){
                                      //  uploadImage(context);
                                        _formkey.currentState.save();
                                        //_formkey.currentState.reset();
                                        _store.editProduct(({
                                          'name' : _name,
                                          'image' : _imageURL,
                                        }
                                        ), category.id);
                                      }
                                  },
                                text: 
                                Text(
                                  "Add",
                                  style: TextStyle(color: Colors.white,fontSize: 20.0),
                                  textAlign: TextAlign.center,
                                 ),
                                icon: Icon(null),
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
      );
  }

    void takeImage () async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(()
    {
      _image = image;
    });
  }

  void uploadImage(context) async{
    try {
    FirebaseStorage storage = FirebaseStorage.instanceFor(bucket: 'gs://review-77112.appspot.com');
    Reference ref = storage.ref().child(p.basename( _image.path));
     UploadTask storageUploadTask = ref.putFile(_image);
    TaskSnapshot taskSnapshot = await storageUploadTask.whenComplete(() => null);
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