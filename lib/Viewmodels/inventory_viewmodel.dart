import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/inventory_models.dart';
import '../repository/inventory_repo.dart';

class InventoryViewmodel extends ChangeNotifier {
  final InventoryModels _inventoryModels = InventoryModels();
  final InventoryRepository _repository = InventoryRepository();

  StreamSubscription? productSubscription;

  InventoryViewmodel() {
    getProducts();
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> get docs =>
      _inventoryModels.docs;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> get filteredDocs =>
      _inventoryModels.filteredDocs;

  String get searchText => _inventoryModels.searchText;

  int get inStock => _inventoryModels.inStock;

  int get lowStock => _inventoryModels.lowStock;

  bool get loading => _inventoryModels.loading;

  void getProducts() {
    productSubscription = _repository.getProducts().listen(
          (snapshot) {
        _inventoryModels.docs = snapshot.docs;

        calculateStock();

        filterProducts();

        _inventoryModels.loading = false;

        notifyListeners();
      },
    );
  }

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

  void calculateStock() {
    _inventoryModels.inStock = 0;
    _inventoryModels.lowStock = 0;

    for (var product in _inventoryModels.docs) {
      var data = product.data();

      double quantity = getNumber(
        data['pquantity'],
      );

      double minStock = getNumber(
        data['pminstock'],
      );

      if (quantity > minStock) {
        _inventoryModels.inStock++;
      } else if (quantity > 0 &&
          quantity <= minStock) {
        _inventoryModels.lowStock++;
      }
    }
  }

  void searchProduct(String value) {
    _inventoryModels.searchText = value;

    filterProducts();

    notifyListeners();
  }

  void filterProducts() {
    _inventoryModels.filteredDocs = _inventoryModels.docs.where(
          (doc) {
        var data = doc.data();

        String productName =
            data['pname']?.toString().toLowerCase() ?? "";

        return productName.contains(
          _inventoryModels.searchText.toLowerCase(),
        );
      },
    ).toList();
  }

  Future<void> deleteProduct(String id) async =>
      await _repository.deleteProduct(id);

  @override
  void dispose() {
    productSubscription?.cancel();
    super.dispose();
  }
}