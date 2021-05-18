import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_gp/Model/product.dart';


class Store{
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  addProduct(Product product){
    _firebaseFirestore.collection('Product').add({
      'name' : product.name,
      'image' : product.image,
      'category': product.category,
    });
  }

  Stream<QuerySnapshot> loadProduct (){
    return _firebaseFirestore.collection('Product').snapshots();
  }


  deleteProduct(documentId){
    _firebaseFirestore.collection('Product').doc(documentId).delete();
  }


  editProduct(data, documentId) {
    _firebaseFirestore
        .collection('Product')
        .doc(documentId)
        .update(data);
  }
}