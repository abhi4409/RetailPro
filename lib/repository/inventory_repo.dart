import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/inventory_services.dart';

class InventoryRepository {
  final InventoryServices _services = InventoryServices();
  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts() {
    return _services.getProducts();
  }

  Future<void> deleteProduct(
      String id,
      ) async {
    await _services.deleteProduct(
      id,
    );
  }
}