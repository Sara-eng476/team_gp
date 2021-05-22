import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:team_gp/Model/category.dart';
import 'package:team_gp/Screens/Admin/category/add.dart';
import 'package:team_gp/Screens/Admin/product/view.dart';
import 'package:team_gp/Screens/Admin/profile/settings.dart';
import 'package:team_gp/Screens/Admin/profile/showProfile.dart';
import 'package:team_gp/Screens/Services/categ.dart';
import 'package:team_gp/Screens/Admin/category/edit.dart';

import '../dashboard.dart';

class ViewCategory extends StatefulWidget {
  @override
  _ViewCategoryState createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => CustomDialog());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red[600],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadCategory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Category> categories = [];
              for (var doc in snapshot.data.docs) {
                var data = doc.data();
                categories.add(Category(
                  id: doc.id,
                  name: data['name'],
                  image: data['image'],
                ));
              }
              return StaggeredGridView.countBuilder(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                  crossAxisCount: 2,
                  crossAxisSpacing: 45,
                  mainAxisSpacing: 30,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                      // This Will Call When User Click On ListView Item
                   /*    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryDetails(
                      product: products[index],
                    ),
                  ),
                ); */
                    },
                        child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                child: Image(
                                  image: NetworkImage(
                                    categories[index].image,
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
                                  height: 40,
                                  color: Colors.grey[100],
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        categories[index].name.toUpperCase(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.red[900],
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          letterSpacing: 1,
                                          height: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTapUp: (details) {
                                double dx = details.globalPosition.dx;
                                double dy = details.globalPosition.dy;
                                double dx2 =
                                    MediaQuery.of(context).size.width - dx;
                                double dy2 =
                                    MediaQuery.of(context).size.width - dy;
                                showMenu(
                                    context: context,
                                    position:
                                        RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                                    items: [
                                      MyPopUpMenuItem(
                                        onClick: () {
                                          Navigator.pushNamed(
                                              context, EditCategory.id,
                                              arguments: categories[index]);
                                        },
                                        child: Center(
                                            child: Icon(
                                          Icons.edit,
                                          color: Colors.red[600],
                                        )),
                                      ),
                                      MyPopUpMenuItem(
                                        onClick: () {
                                          _store.deleteCategory(
                                              categories[index].id);
                                          Navigator.pop(context);
                                        },
                                        child: Center(
                                            child: Icon(
                                          Icons.delete,
                                          color: Colors.red[600],
                                        )),
                                      ),
                                    ]);
                              },
                              child: Opacity(
                                opacity: 0.9,
                                child: Container(
                                    margin: EdgeInsets.all(0),
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.red[100],
                                        border: Border.all(
                                            width: 1, color: Colors.red[700])),
                                    child: Icon(
                                      Icons.brightness_1_rounded,
                                      color: Colors.red[700],
                                      size: 11,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (index) {
                    return new StaggeredTile.count(1, index.isEven ? 1.2 : 1.2);
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

      ////// كا اللي فات دا الهوم بتاع الكاتيجوري

      //// دا البوتن بتاع الاد

      /* floatingActionButton: GradientButton(
        width: 70,
        height: 70,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => CustomDialog());
        },
        text: Text(''),
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 22,
        ),
      ),*/
      
    );
  }
}

class MyPopUpMenuItem<T> extends PopupMenuItem<T> {
  final Widget child;
  final Function onClick;

  MyPopUpMenuItem({@required this.child, @required this.onClick})
      : super(
          child: child,
        );

  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopUpMenuItemState();
  }
}

class MyPopUpMenuItemState<T, PopMenuState>
    extends PopupMenuItemState<T, MyPopUpMenuItem<T>> {
  @override
  void handleTap() {
    widget.onClick();
  }
}
