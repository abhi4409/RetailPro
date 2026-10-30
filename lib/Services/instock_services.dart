import 'package:cloud_firestore/cloud_firestore.dart';

class InstockServices {
  final CollectionReference<Map<String, dynamic>> products =
  FirebaseFirestore.instance.collection(
    'productsdata',
  );

  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() {
    return products.snapshots();
  }
}