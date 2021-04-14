import 'dart:math';

//import 'package:team_gp/Screens/Admin/category/view.dart';
import 'package:team_gp/Screens/Login/login_form.dart';
import 'package:team_gp/Screens/Widget/button.dart';
import 'package:flutter/material.dart';
import 'package:team_gp/Screens/Services/auth.dart';



class RegesterForm extends StatefulWidget{
  @override
  _RegesterFormState createState() => _RegesterFormState();
}

class _RegesterFormState extends State<RegesterForm> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final  _formKey = GlobalKey<FormState>();
  String _email,_password;
  final _auth= Auth();

  

  @override
  void initState() {
    super.initState();
  }

  @override 
  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey ,
        child: Column(
          children: [

             Text("Hey, SignUp now" ,
                    textAlign: TextAlign.center,
                      style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey[900],
                    fontWeight: FontWeight.bold
                    ),
                    ),
            SizedBox(
                height: 25,
              ),

            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value)
              {
                  
              },
              controller: _nameController,
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
                icon:Icon(Icons.perm_identity,color: Colors.blueGrey[600],),
                labelText: "Name",focusColor: Colors.blueGrey[600],hoverColor: Colors.blueGrey[600],
              ),
            // autovalidate: true,
            ),

              SizedBox(
                height: 20,
              ),

            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value)
              {
                  _email = value;
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
                icon:Icon(Icons.email_rounded,color: Colors.blueGrey[600],),
                labelText: "Email",focusColor: Colors.blueGrey[600],hoverColor: Colors.blueGrey[600],
              ),
              keyboardType: TextInputType.emailAddress,
             //autovalidate: true,
            ),

              SizedBox(
                height: 20,
              ),

            TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value)
              {
                  _password = value;
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
                icon:Icon(Icons.lock,color: Colors.blueGrey[600],),
                labelText: "Password",focusColor: Colors.blueGrey[600],hoverColor: Colors.blueGrey[600],
              ),
              obscureText: true,
             //autovalidate: true,
            ),
            SizedBox(
              height: 20,
            ),
           
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) => GradientButton(
                    width: 150,
                    height: 45,
                    onPressed: () async { 
                      if(_formKey.currentState.validate())
                      {
                          _formKey.currentState.save();
                          print(_email);
                          print(_password);
                          try{
                         final authReslt= await _auth.signUp(_email, _password);
                         Navigator.push(context,
                                        MaterialPageRoute(builder: (_) => LoginForm()));
                          }catch(e){
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                e.message,
                                //"Please Enter Vail Data"
                              ),
                            ));
                          }
                      }
                    },
                    text: Text(
                      'Regester',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    icon: Icon(
                      Icons.arrow_forward_sharp,
                      color: Colors.white,
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}