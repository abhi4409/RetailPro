import 'package:cloud_firestore/cloud_firestore.dart';

class LowstockModels {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> lowStockProducts;
  bool loading;
  String error;
  LowstockModels({
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? lowStockProducts,
    this.loading = true,
    this.error = "",
  }) : lowStockProducts = lowStockProducts ?? [];
}