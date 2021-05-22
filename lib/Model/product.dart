import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name;
  String image;
  String category;
  String createdAt;
  Timestamp updatesAt;

  Product({
    this.name,
    this.image,
    this.id,
    this.category,
    this.createdAt,
    this.updatesAt,
  });
}