import 'package:flutter/cupertino.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../static.dart';
import 'package:team_gp/Screens/Notification/addReviewNoti.dart';

class SecondFakeReview extends StatefulWidget {
  @override
  _SecondFakeReviewState createState() => _SecondFakeReviewState();
}

class _SecondFakeReviewState extends State<SecondFakeReview> {

  //static int countFav= 4;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
        AppBar(
        title: Text("CATEGORIES",
            style: TextStyle(color: Colors.black, fontSize: 16.5)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.red[100],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.red[700],
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      
      body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              children: [
                 Badge(
                   padding: EdgeInsets.all(8),
                   toAnimate: false,
                   /* badgeContent: Text("$ValueOfNotificatio.countFav",
                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), */
                     child: buildButton(
                     text: "Fake Review",
                     onClicked: () {
                       setState(() {
                         ValueOfNotificatio.countFav +=1;
                        // return AddReviewNotification();
                       });
                     },
                ),
                 ),
                AddReviewNotification(),
            ],),
            ),
      ),
    );
  }
}

 Widget buildButton({
    @required String text,
    @required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );