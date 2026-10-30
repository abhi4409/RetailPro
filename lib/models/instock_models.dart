import 'package:cloud_firestore/cloud_firestore.dart';

class InstockModels {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> inStockProducts;
  bool loading;
  String error;

  InstockModels({
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? inStockProducts,
    this.loading = true,
    this.error = "",
  }) : inStockProducts = inStockProducts ?? [];
}