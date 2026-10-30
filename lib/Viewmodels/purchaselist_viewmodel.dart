import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/purchaselist_models.dart';
import '../repository/purchaselist_repo.dart';

class PurchaseListViewmodel extends ChangeNotifier {
  final PurchaseListModels _purchaseListModels = PurchaseListModels();
  final PurchaseListRepository _repository = PurchaseListRepository();

  StreamSubscription? purchaseSubscription;

  PurchaseListViewmodel() {
    getPurchases();
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> get purchaseDocs =>
      _purchaseListModels.purchaseDocs;

  String get searchText => _purchaseListModels.searchText;

  double get totalPurchase => _purchaseListModels.totalPurchase;

  Set<String> get suppliers => _purchaseListModels.suppliers;

  String get lastDate => _purchaseListModels.lastDate;

  int get lastPurchaseItems => _purchaseListModels.lastPurchaseItems;

  bool get loading => _purchaseListModels.loading;

  void getPurchases() {
    purchaseSubscription = _repository.getPurchases().listen(
          (snapshot) {
        _purchaseListModels.purchaseDocs = snapshot.docs;
        calculatePurchaseData();
        _purchaseListModels.loading = false;
        notifyListeners();
      },
    );
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> get filteredDocs {
    return _purchaseListModels.purchaseDocs.where(
          (doc) {
        var data = doc.data();
        String supplier =
            data['suppliername']?.toString().toLowerCase() ?? "";

        return supplier.contains(
          _purchaseListModels.searchText.toLowerCase(),
        );
      },
    ).toList();
  }

  void searchPurchase(String value) {
    _purchaseListModels.searchText = value;
    notifyListeners();
  }

  void calculatePurchaseData() {
    _purchaseListModels.totalPurchase = 0;
    _purchaseListModels.suppliers = {};
    DateTime? lastPurchaseDate;
    _purchaseListModels.lastPurchaseItems = 0;

    for (var doc in _purchaseListModels.purchaseDocs) {
      var data = doc.data();
      double amount = double.tryParse(
        data['total']?.toString() ?? '0',
      ) ??
          0;

      _purchaseListModels.totalPurchase += amount;

      String supplier = data['suppliername']?.toString().trim() ?? '';
      if (supplier.isNotEmpty) {
        _purchaseListModels.suppliers.add(
          supplier.toLowerCase(),
        );
      }

      if (data['date'] is Timestamp) {
        DateTime date = (data['date'] as Timestamp).toDate();

        if (lastPurchaseDate == null || date.isAfter(lastPurchaseDate)) {
          lastPurchaseDate = date;
          List items = data['items'] is List ? data['items'] : [];
          _purchaseListModels.lastPurchaseItems = items.length;
        }
      }
    }

    if (lastPurchaseDate == null) {
      _purchaseListModels.lastDate = "No purchases";
    } else {
      _purchaseListModels.lastDate =
      "${lastPurchaseDate.day}/${lastPurchaseDate.month}/${lastPurchaseDate.year}";
    }
  }

  @override
  void dispose() {
    purchaseSubscription?.cancel();
    super.dispose();
  }
}