import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:team_gp/Model/category.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team_gp/Screens/Services/categ.dart';
import 'package:path/path.dart' as p;
import 'package:team_gp/Screens/Widget/button.dart'; 
import '../../../constant.dart';


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
        return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 50.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
        );
    }
    Widget dialogContent(BuildContext context) {
        return Container(
        margin: EdgeInsets.only(left: 0.0,right: 0.0),
        child: Stack(
            children: <Widget>[
            Container(
                padding: EdgeInsets.only(
                top: 30.0,
                left: 15,
                right: 15
                ),
                margin: EdgeInsets.only(top: 13.0,right: 8.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80),
                      bottomRight: Radius.circular(80),),
                    /* boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 0.0,
                        offset: Offset(0.0, 0.0),
                    ),
                    ] */),
                child: SingleChildScrollView(
                    child: Form(
                    key : _formkey,
                    autovalidate: true,
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("ADD CATEGORIES",
                      style: TextStyle(color: Colors.black, fontSize: 16.5)),
                      SizedBox(
                        height: 40
                      ),
                      _showImage(),
                        //دا البوتن اللي بنجيب منه الصورة من الجالري
                        /*GestureDetector(onTap: takeImage,
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
                          child: Icon(Icons.add_photo_alternate_rounded, color: Colors.blueGrey[500], size: 40,))),*/
                        // دا البوتن اللي بيضيف الصورة
                        /*GestureDetector(onTap:() { uploadImage(context);},
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
                          child: Icon(Icons.check_circle , color: Colors.blueGrey[500], size: 40,))),*/
                        SizedBox(height:20,),
                        // التيكست فيلد بتاع الاسم
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
                        SizedBox(height: 50.0),
                          // البوتن
                    /*  Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child:FlatButton(
                            child: Text('ADD',style: TextStyle(color: Colors.white, fontSize: 15,)),
                            minWidth: 100.0,
                            height: 50,
                            color: Colors.red[700],
                            onPressed: () {
                              uploadImage(context);
                              if(_formkey.currentState.validate()){
                                //  uploadImage(context);
                                _formkey.currentState.save();
                                //_formkey.currentState.reset();
                                _store.addCategory(Category(
                                  name: _name,
                                  image: _imageURL,
                                ));
                              }
                            },
                          ),),
                      ),*/
                      GradientButton(
                      width: 109,
                      height: 50,
                      onPressed: () {
                              uploadImage(context);
                              if(_formkey.currentState.validate()){
                                //  uploadImage(context);
                                _formkey.currentState.save();
                                //_formkey.currentState.reset();
                                _store.addCategory(Category(
                                  name: _name,
                                  image: _imageURL,
                                ));
                              }
                            },
                      text: Text(
                        "Add",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      icon: Icon(Icons.add,size: 15,color: Colors.white,),
                    ),
                        SizedBox(height: 20,),
                    ],
                    ),
                  ),
                ),
            ),
            // close دا ال 
            Positioned(
                right: 0.0,
                child: GestureDetector(
                onTap: (){
                    Navigator.of(context).pop();
                },
                child: Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: Colors.red[700],
                    child: Icon(Icons.close, color: Colors.white,size: 20,),
                    ),
                ),
                ),
            ),
            ],
        ),
        );
    }
    // دي كنت عملاها بتاخد الصورة من الكاميرا زوديها لو عايزاا بس حسيت المكان هيبقي زحمة 
    void pickImage() async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState((){
      _image = image;
    });
  }  // الفانكشن خلصت هنا  
   // دي الفانكشن اللي بتفتح الصرو من الجالري                          
  void takeImage () async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState((){
      _image = image;
    });
  }
///////////////////
  /*Widget _decideImageView()
  {
    if(_image != null){
      return Image.file(_image);
    }else
    return Text("No Image Selected");
  }*/
/////// الفانكشن اللي بتخزن الصور في الستوردج
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
// الفانكشن خلصت هنا 
}