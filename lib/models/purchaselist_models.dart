import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseListModels {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> purchaseDocs;
  String searchText;
  double totalPurchase;
  Set<String> suppliers;
  String lastDate;
  int lastPurchaseItems;
  bool loading;

  PurchaseListModels({
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? purchaseDocs,
    this.searchText = "",
    this.totalPurchase = 0,
    Set<String>? suppliers,
    this.lastDate = "No purchases",
    this.lastPurchaseItems = 0,
    this.loading = true,
  })  : purchaseDocs = purchaseDocs ?? [],
        suppliers = suppliers ?? {};
}