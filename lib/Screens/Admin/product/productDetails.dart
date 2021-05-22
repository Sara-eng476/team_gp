//import 'package:admin/models/favourite.dart';
import 'package:team_gp/Model/product.dart';
import 'package:team_gp/Screens/Admin/review/new_Review.dart';
import 'package:team_gp/Screens/Admin/review/old_Review.dart';
import 'package:team_gp/Screens/Services/rev.dart';
//import 'package:admin/services/Fav.dart';
import 'package:team_gp/Screens/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  static const roteName = '/productdatails';
  String userid;
  final Product product;
  ProductDetails({Key key, @required this.product}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _store = ReviewFirebase();
  //var isItemInFavouriteList = false;
  //-List<Favourite> favouriteProducts = new List([]);
  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.red[100],
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(widget.product.name.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.5,
              )),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: StreamBuilder(
              stream: _store.loadReviews(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // widget.userid = snapshot.data;
                  // print("userid " + widget.userid);
                  // print("snaaaaaaaaaaaaaaaap " + snapshot.data);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("Category" + " " + widget.product.category+"  •••  "+"Product" + " " + widget.product.name,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 18.0)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("What do you think about this product? these reviews have been verified well, so you must trust us. " ,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 18.0)),
                          ),
                        ),
                        SizedBox(height: 10),
                        Image(
                          image: NetworkImage(
                            widget.product.image,
                          ),
                          fit: BoxFit.fill,
                          width: 120,
                          height: 200,
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(children: <Widget>[
                                Expanded(
                                    child: Divider(
                                  color: Colors.black,
                                  height: 30,
                                  indent: 5,
                                  thickness: 2,
                                )),
                                Text("  "),
                                Text(
                                  "REVIEWS",
                                  style: TextStyle(
                                    color: Colors.red[900],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text("  "),
                                Expanded(
                                    child: Divider(
                                  color: Colors.black,
                                  height: 30,
                                  endIndent: 5,
                                  thickness: 2,
                                )),
                              ]),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        OldReviews(
                            product: widget.product, userid: widget.userid),
                        NewReview(
                            product: widget.product, userid: widget.userid),
                      ],
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
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
        ));
  }
}

// SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
// FirebaseFirestore firestore = FirebaseFirestore.instance;
// DocumentReference userref;
// User firebaseUser;
// FirebaseAuth auth = FirebaseAuth.instance.currentUser.uid;
// firebaseUser = auth.user;
// String favouriteList;

// checkItemInCart(String productID, BuildContext context) {
//   sharedPreferences.getStringList(favouriteList).contains(productID)
//       ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text("Item is already in Favourite List"),
//            ))
//       : addItemToFavourite(productID, context);
// }

// addItemToFavourite(String productID, BuildContext context) {
//   List tempList = sharedPreferences.getStringList(favouriteList);
//   tempList.add(productID);
//   userref = firestore.collection('User').doc(firebaseUser.uid);
//     userref.update({'favourites': tempList}).then((value) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text("Item is added to Favourite List"),
//            ));
//            sharedPreferences.setStringList(favouriteList,tempList );
//     });
// }
