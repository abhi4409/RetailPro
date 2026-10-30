import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardModels {
  int productCount;
  double todaySales;
  double totalPurchase;
  double totalProfit;

  List<Map<String, dynamic>> lowStockProducts;
  bool loading;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> productDocs;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> saleDocs;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> purchaseDocs;
  bool productLoaded;
  bool saleLoaded;
  bool purchaseLoaded;
  DashboardModels({
    this.productCount = 0,
    this.todaySales = 0,
    this.totalPurchase = 0,
    this.totalProfit = 0,
    List<Map<String, dynamic>>? lowStockProducts,
    this.loading = true,
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? productDocs,
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? saleDocs,
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? purchaseDocs,
    this.productLoaded = false,
    this.saleLoaded = false,
    this.purchaseLoaded = false,
  })  : lowStockProducts = lowStockProducts ?? [],
        productDocs = productDocs ?? [],
        saleDocs = saleDocs ?? [],
        purchaseDocs = purchaseDocs ?? [];
}