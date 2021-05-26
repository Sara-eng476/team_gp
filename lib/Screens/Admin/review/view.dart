import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:team_gp/Model/product.dart';
import 'package:team_gp/Model/review.dart';
import 'package:team_gp/Screens/Admin/category/view.dart';
import 'package:team_gp/Screens/Admin/product/add.dart';
import 'package:team_gp/Screens/Admin/product/productDetails.dart';
import 'package:team_gp/Screens/Services/rev.dart';
import 'package:team_gp/Screens/Widget/button.dart';
import 'package:team_gp/Screens/Admin/product/edit.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';

class ViewReview extends StatefulWidget {
 
  @override
  _ViewReviewState createState() => _ViewReviewState();
}

class _ViewReviewState extends State<ViewReview> {
  final _store = ReviewFirebase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews",
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

        
      

      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadReviews(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Review> reviews = [];
              for (var doc in snapshot.data.docs) {
                var data = doc.data();
                reviews.add(Review(
                  id: doc.id,
                  comment: data['comment'],
                  userId: data['userId'],
                  productId: data['productId'],
                ));
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // This Will Call When User Click On ListView Item
                    },
                    child: Card(
                      child: Row(
                        children: [
                          Container(
                            width: 90,
                            color: Colors.white,
                            child: Text(
                              //reviews[index].userName,
                              "User" + " : \n" + "Sara\n"
                               "Product" + " : \n" + "Mascara Pretty Woman\n"
                               "Category" + " : \n" + "Mascara",
                               style: TextStyle(
                                      color: Colors.red[900],
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      letterSpacing: 1,
                                      height: 2,
                                    )
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
                                    reviews[index].comment,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      letterSpacing: 1,
                                      height: 2,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),Container(
                            alignment: AlignmentDirectional.centerEnd,
                            child: GestureDetector(
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
                                          _store.deleteReview(
                                              reviews[index].id);
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
