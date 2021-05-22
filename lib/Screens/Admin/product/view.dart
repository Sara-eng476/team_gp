import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:team_gp/Model/product.dart';
import 'package:team_gp/Screens/Admin/category/view.dart';
import 'package:team_gp/Screens/Admin/product/add.dart';
import 'package:team_gp/Screens/Admin/product/productDetails.dart';
import 'package:team_gp/Screens/Services/pro.dart';
import 'package:team_gp/Screens/Widget/button.dart';
import 'package:team_gp/Screens/Admin/product/edit.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

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
        title: Text("PRODUCTS",
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
              builder: (BuildContext context) => AddProduct());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red[600],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

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

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // This Will Call When User Click On ListView Item
                      Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetails(
                      product: products[index],
                    ),
                  ),
                );
                    },
                    child: Card(
                      child: Row(
                        children: [
                          Container(
                            width: 90,
                            height: 80,
                            color: Colors.red[100],
                            child: Image(
                              image: NetworkImage(
                                products[index].image,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Container(
                            width: 180,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    products[index].name.toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.red[900],
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      letterSpacing: 1,
                                      height: 2,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: RatingBarIndicator(
                                      rating: 2.75,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 15.0,
                                      direction: Axis.horizontal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),GestureDetector(
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
                                        color: Colors.red[600],
                                      )),
                                    ),
                                    MyPopUpMenuItem(
                                      onClick: () {
                                        _store.deleteProduct(
                                            products[index].id);
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
                                      borderRadius:
                                          BorderRadius.circular(100),
                                      color: Colors.red[100],
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.red[700])),
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
              );
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
