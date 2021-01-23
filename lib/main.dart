import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_gp/Screens/Login/login.dart';

void main() {
  runApp(
      MaterialApp(home: App(),)
  );
}

class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();

}

class _AppState extends State<App> {

  Color primaryColor= Color(0xff18203d);
  Color secondColor= Color(0xff232c51);
  Color logoColor= Color(0xff25bcbb);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: NetworkImage('https://images.pexels.com/photos/5076516/pexels-photo-5076516.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'),
              height: 250,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Welcom To RoOia !',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Before Purchase anything, You can see the view of customers who tried it. Thank you for using my app ',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              elevation: 0,
              height: 50,
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Login()));
              },
              color: logoColor,
              child: Text('LOGIN',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}





