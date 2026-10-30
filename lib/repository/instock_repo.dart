import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/instock_services.dart';

class InstockRepository {
  final InstockServices _services =
  InstockServices();

  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() {
    return _services.getProducts();
  }
}