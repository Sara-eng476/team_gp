import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:team_gp/Model/category.dart';
import 'package:team_gp/Model/profile.dart';
import 'package:team_gp/Screens/Admin/category/add.dart';
import 'package:team_gp/Screens/Services/profile.dart';

import 'package:team_gp/Screens/Services/categ.dart';
import 'package:team_gp/Screens/Widget/button.dart';
import 'package:team_gp/Screens/Admin/category/edit.dart';

import 'changeProfileImage.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _adminProfile = AdminProfile();
  final navigatorKey = GlobalKey<NavigatorState>();
/*

@override
  void initState() {
    super.initState();
  }
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: Text('Admin Page'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.00),
            child: Icon(
              Icons.search,
              size: 28.0,
            ),
          ),
        ],
      ),

      backgroundColor: Colors.blueGrey[50], //Colors.pink[50],
      body: StreamBuilder<QuerySnapshot>(
          stream: _adminProfile.loadAdmin(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Admin> adminData = [];
              for (var doc in snapshot.data.docs) {
                var data = doc.data();
                adminData.add(Admin(
                  id: doc.id,
                  name: data['name'],
                  image: data['image'],
                ));
              }

              return StaggeredGridView.countBuilder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  crossAxisCount: 1,
                  itemCount: adminData.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            offset: const Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              child: Image(
                                image: NetworkImage(
                                  adminData[index].image,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            child: Opacity(
                              opacity: 0.9,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      adminData[index].name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        letterSpacing: 1,
                                        height: 2,
                                      ),
                                    ),
                                    FlatButton.icon(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  ChangeProfileData());
                                        },
                                        icon: Icon(
                                          Icons.person_add,
                                          size: 30,
                                        ),
                                        label: Text("Edit Profile")),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) {
                    return new StaggeredTile.count(1, index.isEven ? 1.2 : 1.6);
                  });
            } else {
              return Center(
                child: Text(
                  'Loading....',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.blueGrey[900],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black54,
                        offset: Offset(5.0, 5.0),
                      ),
                      Shadow(
                        color: Color(0xFFE0F7FA),
                        blurRadius: 10.0,
                        offset: Offset(-5.0, 5.0),
                      )
                    ],
                    letterSpacing: -1.0,
                    wordSpacing: 5.0,
                  ),
                ),
              );
            }
          }),

      //// دا البوتن بتاع الاد
    );
  }
}
