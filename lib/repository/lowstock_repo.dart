import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/lowstock_services.dart';

class LowstockRepository {
  final LowstockServices _services =
  LowstockServices();
  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() {
    return _services.getProducts();
  }
}