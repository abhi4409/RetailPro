import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/dashboard_services.dart';

class DashboardRepository {
  final DashboardServices _services =
  DashboardServices();

  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() {
    return _services.getProducts();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSales() {
    return _services.getSales();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPurchases() {
    return _services.getPurchases();
  }
}