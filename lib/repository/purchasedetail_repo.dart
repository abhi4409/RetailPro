import '../services/purchasedetail_services.dart';

class PurchaseDetailRepository {
  final PurchaseDetailServices _services =
  PurchaseDetailServices();

  List getItems(
      Map<String, dynamic> data,
      ) {
    return _services.getItems(
      data,
    );
  }

  String getDate(
      Map<String, dynamic> data,
      ) {
    return _services.getDate(
      data,
    );
  }
}