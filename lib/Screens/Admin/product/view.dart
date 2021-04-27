import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:team_gp/Model/product.dart';
import 'package:team_gp/Screens/Admin/category/add.dart';
import 'package:team_gp/Screens/Admin/category/edit.dart';
import 'package:team_gp/Screens/Admin/product/add.dart';
import 'package:team_gp/Screens/Services/prod.dart';
import 'package:team_gp/Screens/Widget/button.dart';
import 'package:team_gp/Screens/Admin/product/edit.dart';

class ViewProduct extends StatefulWidget {
  @override
  _ViewProductState createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey[500],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.blueGrey[50],
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadProduct(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> products = [];
              for (var doc in snapshot.data.docs) {
                var data = doc.data();
                products.add(Product(
                  id: doc.id,
                  name: data['name'],
                  image: data['image'],
                  category: data['category'],
                ));
              }

              return StaggeredGridView.countBuilder(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  crossAxisCount: 2,
                  crossAxisSpacing: 45,
                  mainAxisSpacing: 30,
                  itemCount: products.length,
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
                                  products[index].image,
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
                                height: 60,
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      products[index].name.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        letterSpacing: 1,
                                        height: 2,
                                      ),
                                    )
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
                                            context, EditProduct.id,
                                            arguments: products[index]);
                                      },
                                      child: Center(
                                          child: Icon(
                                        Icons.edit,
                                        color: Colors.blueGrey[700],
                                      )),
                                    ),
                                    MyPopUpMenuItem(
                                      onClick: () {
                                        _store
                                            .deleteProduct(products[index].id);
                                        Navigator.pop(context);
                                      },
                                      child: Center(
                                          child: Icon(
                                        Icons.delete,
                                        color: Colors.blueGrey[700],
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
                                      color: Colors.blue[50],
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.blueGrey[200])),
                                  child: Icon(
                                    Icons.brightness_1_rounded,
                                    color: Colors.blueGrey[500],
                                    size: 10,
                                  )),
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
      ////// كا اللي فات دا الهوم بتاع الكاتيجوري

      //// دا البوتن بتاع الاد

      floatingActionButton: GradientButton(
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
      ),
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
