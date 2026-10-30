import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/lowstock_models.dart';
import '../repository/lowstock_repo.dart';

class LowstockViewmodel extends ChangeNotifier {
  final LowstockModels _lowstockModels = LowstockModels();
  final LowstockRepository _repository = LowstockRepository();

  StreamSubscription? productSubscription;

  LowstockViewmodel() {
    getLowStockProducts();
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> get lowStockProducts =>
      _lowstockModels.lowStockProducts;

  bool get loading => _lowstockModels.loading;

  String get error => _lowstockModels.error;

  void getLowStockProducts() {
    productSubscription = _repository.getProducts().listen(
          (snapshot) {
        _lowstockModels.lowStockProducts = snapshot.docs.where((product) {
          var data = product.data();
          int quantity =
              int.tryParse(data['pquantity']?.toString() ?? '0') ?? 0;
          int minstock =
              int.tryParse(data['pminstock']?.toString() ?? '0') ?? 0;
          return quantity <= minstock;
        }).toList();

        _lowstockModels.loading = false;
        _lowstockModels.error = "";
        notifyListeners();
      },
      onError: (e) {
        _lowstockModels.loading = false;
        _lowstockModels.error = e.toString();
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    productSubscription?.cancel();
    super.dispose();
  }
}