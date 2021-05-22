import 'package:team_gp/Model/product.dart';
import 'package:team_gp/Model/review.dart';
import 'package:team_gp/Screens/Services/rev.dart';
import 'package:flutter/material.dart';

class OldReviews extends StatefulWidget {
  final Product product;
  final String userid;
  OldReviews({Key key, @required this.product, @required this.userid})
      : super(key: key);
  OldReviewsState createState() => OldReviewsState();
}

class OldReviewsState extends State<OldReviews> {
  final _store = ReviewFirebase();

  TextEditingController _controller = TextEditingController();
  bool _isEnable = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _store.loadReviews(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData == null) {
            return Text("Empty");
          }
          if (snapshot.hasData) {
            // final docs = snapshot.data.docs;
            List<Review> reviews = [];
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              if (widget.product.id == data['productId']) {
                print(data['productId']);
                reviews.add(Review(
                  id: doc.id,
                  productId: data['productId'],
                  comment: data['comment'],
                  createAt: data['createAt'],
                  userId: data['userId'],
                ));
              }
            }
            return reviews.isEmpty
                ? Center(child: Text('Empty'))
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: reviews.length,
                    itemBuilder: (ctx, index) => Container(
                          width: 10,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.grey)),
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(reviews[index].comment),
                        ));
          }
        });
  }
}