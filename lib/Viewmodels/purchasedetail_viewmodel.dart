import 'package:flutter/material.dart';
import '../models/purchasedetail_models.dart';
import '../repository/purchasedetail_repo.dart';

class PurchaseDetailViewmodel extends ChangeNotifier {
  late PurchaseDetailModels _purchaseDetailModels;
  final PurchaseDetailRepository _repository = PurchaseDetailRepository();
  PurchaseDetailViewmodel(
      Map<String, dynamic> purchaseData,
      ) {
    _purchaseDetailModels = PurchaseDetailModels(
      data: purchaseData,
    );
    getPurchaseDetails();
  }
  Map<String, dynamic> get data => _purchaseDetailModels.data;
  List get items => _purchaseDetailModels.items;
  String get date => _purchaseDetailModels.date;
  void getPurchaseDetails() {
    _purchaseDetailModels.items = _repository.getItems(
      _purchaseDetailModels.data,
    );
    _purchaseDetailModels.date = _repository.getDate(
      _purchaseDetailModels.data,
    );
  }
}