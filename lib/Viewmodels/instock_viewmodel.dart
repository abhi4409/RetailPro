import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/instock_models.dart';
import '../repository/instock_repo.dart';

class InstockViewmodel extends ChangeNotifier {
  final InstockModels _instockModels = InstockModels();
  final InstockRepository _repository = InstockRepository();

  StreamSubscription? productSubscription;

  InstockViewmodel() {
    getInStockProducts();
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> get inStockProducts =>
      _instockModels.inStockProducts;

  bool get loading => _instockModels.loading;

  String get error => _instockModels.error;

  void getInStockProducts() {
    productSubscription = _repository.getProducts().listen(
          (snapshot) {
        _instockModels.inStockProducts = snapshot.docs.where((product) {
          var data = product.data();
          int quantity = int.tryParse(data['pquantity']?.toString() ?? '0') ?? 0;
          int minstock = int.tryParse(data['pminstock']?.toString() ?? '0') ?? 0;
          return quantity > minstock;
        }).toList();

        _instockModels.loading = false;
        _instockModels.error = "";
        notifyListeners();
      },
      onError: (e) {
        _instockModels.loading = false;
        _instockModels.error = e.toString();
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