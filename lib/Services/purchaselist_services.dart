import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseListServices {
  final CollectionReference<Map<String, dynamic>> purchases =
  FirebaseFirestore.instance.collection('purchase',);
  Stream<QuerySnapshot<Map<String, dynamic>>> getPurchases() {
    return purchases.snapshots();
  }
}