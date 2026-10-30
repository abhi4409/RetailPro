import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardServices {
  final CollectionReference<Map<String, dynamic>> products = FirebaseFirestore.instance.collection(
    'productsdata',
  );
  final CollectionReference<Map<String, dynamic>> sales = FirebaseFirestore.instance.collection(
    'sales',
  );
  final CollectionReference<Map<String, dynamic>> purchases = FirebaseFirestore.instance.collection(
    'purchase',
  );

  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() => products.snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> getSales() => sales.snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> getPurchases() => purchases.snapshots();
}