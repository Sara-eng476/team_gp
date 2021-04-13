import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_gp/Model/category.dart';


class Store{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  addCategory(Category category){
    _firebaseFirestore.collection('Category').add({
      'name' : category.name,
      'image' : category.image,
    });
  }

  Stream<QuerySnapshot> loadCategory (){
    return _firebaseFirestore.collection('Category').snapshots();
  }
}