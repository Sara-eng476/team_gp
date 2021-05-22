import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_gp/Model/profile.dart';

class AdminProfile {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  addAdmin(Admin admin) {
    _firebaseFirestore.collection('Admin').add({
      'id': admin.id,
      'name': admin.name,
      'email': admin.email,
      'image': admin.image,
      'password': admin.password,
    });
  }

  Stream<QuerySnapshot> loadAdmin() {
    return _firebaseFirestore.collection('Admin').snapshots();
  }

  deleteAdmin(documentId) {
    _firebaseFirestore.collection('Admin').doc(documentId).delete();
  }

  editAdmin(data, documentId) {
    _firebaseFirestore.collection('Admin').doc(documentId).update(data);
  }
}