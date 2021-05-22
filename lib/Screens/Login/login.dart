import 'package:flutter/material.dart';
import 'package:team_gp/Screens/Widget/curveWidget.dart';
import 'package:team_gp/Screens/Login/login_form.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blueGrey[50], Colors.blueGrey[50]],
        )),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              CurvedWidget(
                child: Container(
                  padding: const EdgeInsets.only(top: 0, left: 0),
                  width: double.infinity,
                  height: 280,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.white.withOpacity(0.4)],
                  )),
                  child: Image.asset(
                    'assets/icon8.png',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 85, left: 105),
                child: Text(
                  "Welcom To RO'YA",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey[900],
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 200),
                child: LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
