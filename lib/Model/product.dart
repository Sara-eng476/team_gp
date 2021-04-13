import 'package:cloud_firestore/cloud_firestore.dart';


class Product{
  String id;
  String name;
  String image;
  Timestamp createdAt;
  Timestamp updatesAt;
  List category;
  

  Product();
  
  Product.fromMap(Map<String, dynamic> data)
  {
    id = data['id'];
    name = data['name'];
    image = data['image'];
    createdAt = data['createdAt'];
    updatesAt = data['updatedAt'];
    category = data['category'];
  }

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'name' : name,
      'image' : image,
      'createdAt' : createdAt,
      'updatedAt' : updatesAt,
      'category' : category,
    };
  }

}