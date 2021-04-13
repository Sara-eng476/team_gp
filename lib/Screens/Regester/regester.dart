import 'package:flutter/material.dart';
import 'package:team_gp/Screens/Widget/curveWidget.dart';
import 'package:team_gp/Screens/Regester/regester_form.dart';



class Regester extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Color(0xff6a515e),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xfff2cbd0), Color(0xfff4ced9) ],
          )
        ),
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
                      colors: [Colors.white, Colors.white.withOpacity(0.4) ],
                    )
                  ),
                  
                  child:  
                    Image.asset('assets/icon8.png',
                    ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 85, left: 105),
                child: Text("Welcom To RO'YA" ,
                    textAlign: TextAlign.center,
                      style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff6a515e),
                    fontWeight: FontWeight.bold
                    ),
                    ),
              ),
              Container(
                    margin: const EdgeInsets.only(top: 220),
                    child: RegesterForm(),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
