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
    _lowstockModels.loading = true;
    _lowstockModels.error = "";

    productSubscription = _repository.getProducts().listen(
          (snapshot) {
        List<QueryDocumentSnapshot<Map<String, dynamic>>> lowItems = [];

        for (var product in snapshot.docs) {
          var data = product.data();

          double quantity = double.tryParse(
            data['pquantity']?.toString() ?? '0',
          ) ??
              0.0;

          double minStock = double.tryParse(
            data['pminstock']?.toString() ?? '0',
          ) ??
              0.0;

          if (quantity > 0 && quantity <= minStock) {
            lowItems.add(product);
          }
        }

        _lowstockModels.lowStockProducts = lowItems;
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