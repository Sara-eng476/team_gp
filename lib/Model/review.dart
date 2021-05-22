import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String id;
  String productId;
  String comment;
  Timestamp createAt;
  String userId;

  Review({this.comment, this.createAt, this.id, this.productId, this.userId});
}