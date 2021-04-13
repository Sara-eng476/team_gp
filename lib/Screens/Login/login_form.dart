import 'package:team_gp/Screens/Admin/category/view.dart';
import 'package:team_gp/Screens/Widget/button.dart';
import 'package:flutter/material.dart';
import 'package:team_gp/Screens/Regester/regester.dart';
import 'package:team_gp/Screens/Services/auth.dart';




class LoginForm extends StatefulWidget{
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
          key: _formKey,
          child: Column(
            children: [

              Text("Please, LogIn" ,
                    textAlign: TextAlign.center,
                      style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff6a515e),
                    fontWeight: FontWeight.bold
                    ),
                    ),
            SizedBox(
                height: 25,
              ),

              TextFormField(
                controller: _emailController,
                validator: (value){
                  if(value.isEmpty){
                    return 'Please enter your name'; 
                  }
                },
                onSaved: (value)
                {
                    _email = value;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.pink[50],
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color(0xff6a515e),
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color(0xff6a515e),
                    )
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color(0xff6a515e),
                    )
                  ),
                  icon:Icon(Icons.email_rounded),
                  labelText: "Email",
                ),
                keyboardType: TextInputType.emailAddress,
              // autovalidate: true,
              ),

                SizedBox(
                    height: 20,
                ),

              TextFormField(
                controller: _passwordController,
                validator: (value){
                  if(value.isEmpty){
                    return 'Please enter password'; 
                  }
                },
                onSaved: (value)
                {
                    _password = value;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.pink[50],
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color(0xff6a515e),
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color(0xff6a515e),
                    )
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Color(0xff6a515e),
                    )
                  ),
                  icon:Icon(Icons.lock),
                  labelText: "Password",
                ),
                obscureText: true,
             //  autovalidate: true,
              ),
              SizedBox(
                height: 20,
              ),
              GradientButton(
                width: 150,
                height: 45,
                onPressed: () async {
                  if(_formKey.currentState.validate())
                  {
                      _formKey.currentState.save();
                      print(_email);
                      print(_password);
                      try{
                        final reslt= await _auth.signIn(_email, _password);
                        Navigator.push(context,
                                       MaterialPageRoute(builder: (_) => ViewCategory()));
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
                  'LogIn',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),

              SizedBox(
                height: 10,
              ),

              Text("Don't Have an Account ! "),

              GradientButton(
                width: 150,
                height: 45,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_){
                    return Regester();
                  }
                  ));
                },
                text: Text(
                  'SignUp',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
           
            ],
          ),
        ),
    );
  }
}