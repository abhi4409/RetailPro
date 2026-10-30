import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryServices {
  final CollectionReference<Map<String, dynamic>> products =
  FirebaseFirestore.instance.collection(
    'productsdata',
  );

  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() {
    return products.snapshots();
  }

  Future<void> deleteProduct(
      String id,
      ) async {
    await products
        .doc(
      id,
    )
        .delete();
  }
}