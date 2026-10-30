import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryModels {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> docs;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> filteredDocs;
  String searchText;
  int inStock;
  int lowStock;
  bool loading;

  InventoryModels({
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs,
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? filteredDocs,
    this.searchText = "",
    this.inStock = 0,
    this.lowStock = 0,
    this.loading = true,
  })  : docs = docs ?? [],
        filteredDocs = filteredDocs ?? [];
}