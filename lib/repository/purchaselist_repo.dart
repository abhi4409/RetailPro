import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/purchaselist_services.dart';

class PurchaseListRepository {
  final PurchaseListServices _services = PurchaseListServices();
  Stream<QuerySnapshot<Map<String, dynamic>>> getPurchases() {
    return _services.getPurchases();
  }
}