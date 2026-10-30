import '../services/purchase_services.dart';

class PurchaseRepository {
  final PurchaseServices _services = PurchaseServices();

  Future<void> addPurchase(Map<String, dynamic> data) async =>
      await _services.addPurchase(data);

  Future<void> updateStock(
      List<Map<String, dynamic>> purchaseItems,
      String supplierName,
      String billNo,
      ) async =>
      await _services.updateStock(
        purchaseItems,
        supplierName,
        billNo,
      );
}