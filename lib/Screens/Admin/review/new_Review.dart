import 'package:team_gp/Model/product.dart';
import 'package:team_gp/Screens/Admin/product/view.dart';
import 'package:team_gp/Model/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_gp/Screens/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';


class NewReview extends StatefulWidget {
  final Product product;
  final String userid;
  NewReview({Key key, @required this.product, @required this.userid})
      : super(key: key);
  @override
  _NewReviewState createState() => _NewReviewState();
}

class _NewReviewState extends State<NewReview> {
  final _controller = TextEditingController();
  String _enteredMessage = "";
  _sendMessage() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('Review').add({
      'comment': _enteredMessage,
      'createAt': Timestamp.now(),
      'productId': widget.product.id,
      'userId': widget.userid
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[700],
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              
            controller: _controller,
            decoration: InputDecoration(labelText: 'write a review...',filled: true,
      fillColor: Colors.white,),
            onChanged: (val) {
              setState(() {
                _enteredMessage = val;
              });
            },
          )),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.send,color: Colors.white,),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}