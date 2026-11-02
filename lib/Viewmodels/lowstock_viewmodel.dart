import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/lowstock_models.dart';
import '../repository/lowstock_repo.dart';

class LowstockViewmodel extends ChangeNotifier {
  final LowstockModels _lowstockModels = LowstockModels();
  final LowstockRepository _repository = LowstockRepository();

  StreamSubscription? productSubscription;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> _outOfStockProducts = [];

  LowstockViewmodel() {
    getLowStockProducts();
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> get lowStockProducts =>
      _lowstockModels.lowStockProducts;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> get outOfStockProducts =>
      _outOfStockProducts;

  bool get loading => _lowstockModels.loading;

  String get error => _lowstockModels.error;

  int get lowStockCount => lowStockProducts.length;

  int get outOfStockCount => outOfStockProducts.length;

  double getNumber(dynamic value) {
    if (value == null) {
      return 0.0;
    }

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(
      value.toString().trim(),
    ) ??
        0.0;
  }

  bool isOutOfStock(
      Map<String, dynamic> data,
      ) {
    double quantity = getNumber(
      data['pquantity'],
    );

    return quantity <= 0;
  }

  bool isLowStock(
      Map<String, dynamic> data,
      ) {
    double quantity = getNumber(
      data['pquantity'],
    );

    double minStock = getNumber(
      data['pminstock'],
    );

    return quantity > 0 &&
        quantity <= minStock;
  }

  bool isInStock(
      Map<String, dynamic> data,
      ) {
    double quantity = getNumber(
      data['pquantity'],
    );

    double minStock = getNumber(
      data['pminstock'],
    );

    return quantity > minStock;
  }

  String formatQuantity(
      dynamic quantity,
      dynamic unit,
      ) {
    double qty = getNumber(quantity);

    String unitText =
        unit?.toString().trim().toLowerCase() ?? "";

    if (qty == qty.roundToDouble()) {
      return qty.toInt().toString();
    }

    if (unitText == "kg" ||
        unitText == "kgs" ||
        unitText == "kilogram" ||
        unitText == "kilograms") {
      return qty
          .toStringAsFixed(2)
          .replaceAll(
        RegExp(r'0+$'),
        '',
      )
          .replaceAll(
        RegExp(r'\.$'),
        '',
      );
    }

    return qty
        .toStringAsFixed(2)
        .replaceAll(
      RegExp(r'0+$'),
      '',
    )
        .replaceAll(
      RegExp(r'\.$'),
      '',
    );
  }

  void getLowStockProducts() {
    _lowstockModels.loading = true;
    _lowstockModels.error = "";

    productSubscription?.cancel();

    productSubscription =
        _repository.getProducts().listen(
              (snapshot) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>>
            lowItems = [];

            List<QueryDocumentSnapshot<Map<String, dynamic>>>
            outItems = [];

            for (var product in snapshot.docs) {
              Map<String, dynamic> data =
              product.data();

              double quantity = getNumber(
                data['pquantity'],
              );

              double minStock = getNumber(
                data['pminstock'],
              );

              if (quantity <= 0) {
                outItems.add(product);
              } else if (quantity <= minStock) {
                lowItems.add(product);
              }
            }

            _lowstockModels.lowStockProducts =
                lowItems;

            _outOfStockProducts = outItems;

            _lowstockModels.loading = false;
            _lowstockModels.error = "";

            notifyListeners();
          },
          onError: (e) {
            _lowstockModels.loading = false;
            _lowstockModels.error =
                e.toString();

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