import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
                    color: Colors.blueGrey[900],
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

              Text("Don't Have an Account ! ", style: TextStyle(color: Colors.blueAccent[900]),),

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
              Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                            children: <Widget>[
                                Expanded(
                                    child: Divider(
                                      color: Colors.black,
                                      height: 30,
                                      indent: 50,
                                      thickness: 2,
                                    )
                                ),       

                                Text("OR"),        

                                Expanded(
                                    child: Divider(
                                      color: Colors.black,
                                      height: 30,
                                      endIndent: 50,
                                      thickness: 2,
                                    )
                                ),
                            ]
                        ),
                      RaisedButton(
                        onPressed: ()async {
                          await signInWithGoogle();
                                },
                              color: Colors.green,
                              child: Text('SIgnIn with google'),
                                ),
                      RaisedButton(
                        onPressed: ()async {
                         await signOut();
                                },
                           color: Colors.red,
                             child: Text('signOut'),
                                )
                                              ],
                                            ),
                                          ),          
                                      ],
                                    ),
                                  ),
                              );
                            }
                          
        Future <void> signInWithGoogle() async{
          
         GoogleSignInAccount googleSignInAccount= await _googleSignIn.signIn();
         GoogleSignInAuthentication googleSignInAuthentication =await googleSignInAccount.authentication;
         AuthCredential authCredential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken );
        UserCredential usercredential =await _firebaseAuth.signInWithCredential(authCredential);
        User user = usercredential.user;
         print('user email = ${user.email}');
         Navigator.push(context,
        MaterialPageRoute(builder: (_) => ViewCategory()));
        }
        Future<void> signOut() async {
    await _googleSignIn.signOut();
    print('sign out');
  }
}


