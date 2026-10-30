import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/dashboard_models.dart';
import '../repository/dashboard_repo.dart';

class DashboardViewmodel extends ChangeNotifier {
  final DashboardModels _dashboardModels = DashboardModels();
  final DashboardRepository _repository = DashboardRepository();

  StreamSubscription? productSubscription;
  StreamSubscription? saleSubscription;
  StreamSubscription? purchaseSubscription;

  DashboardViewmodel() {
    getDashboardData();
  }

  int get productCount => _dashboardModels.productCount;
  double get todaySales => _dashboardModels.todaySales;
  double get totalPurchase => _dashboardModels.totalPurchase;
  double get totalProfit => _dashboardModels.totalProfit;
  List<Map<String, dynamic>> get lowStockProducts => _dashboardModels.lowStockProducts;
  bool get loading => _dashboardModels.loading;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get productDocs => _dashboardModels.productDocs;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get saleDocs => _dashboardModels.saleDocs;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> get purchaseDocs => _dashboardModels.purchaseDocs;
  bool get productLoaded => _dashboardModels.productLoaded;
  bool get saleLoaded => _dashboardModels.saleLoaded;
  bool get purchaseLoaded => _dashboardModels.purchaseLoaded;

  void getDashboardData() {
    productSubscription = _repository.getProducts().listen(
          (
          snapshot,
          ) {
        _dashboardModels.productDocs = snapshot.docs;
        _dashboardModels.productLoaded = true;
        calculateDashboard();
      },
    );

    saleSubscription = _repository.getSales().listen(
          (
          snapshot,
          ) {
        _dashboardModels.saleDocs = snapshot.docs;
        _dashboardModels.saleLoaded = true;
        calculateDashboard();
      },
    );

    purchaseSubscription = _repository.getPurchases().listen(
          (
          snapshot,
          ) {
        _dashboardModels.purchaseDocs = snapshot.docs;
        _dashboardModels.purchaseLoaded = true;
        calculateDashboard();
      },
    );
  }

  void calculateDashboard() {
    if (!_dashboardModels.productLoaded || !_dashboardModels.saleLoaded || !_dashboardModels.purchaseLoaded) {
      return;
    }

    _dashboardModels.productCount = _dashboardModels.productDocs.length;
    _dashboardModels.lowStockProducts = [];

    for (var product in _dashboardModels.productDocs) {
      var data = product.data();
      int quantity = int.tryParse(
        data['pquantity']?.toString() ?? '0',
      ) ?? 0;
      int minStock = int.tryParse(
        data['pminstock']?.toString() ?? '0',
      ) ?? 0;

      if (quantity <= minStock) {
        _dashboardModels.lowStockProducts.add(
          data,
        );
      }
    }

    double totalSales = 0;
    double totalCost = 0;
    _dashboardModels.todaySales = 0;
    DateTime now = DateTime.now();

    for (var sale in _dashboardModels.saleDocs) {
      var data = sale.data();
      double amount = double.tryParse(
        data['totalAmount']?.toString() ?? '0',
      ) ?? 0;
      totalSales += amount;

      List items = data['items'] is List ? data['items'] : [];

      for (var item in items) {
        for (var product in _dashboardModels.productDocs) {
          if (product.id == item['id']) {
            var productData = product.data();
            double purchasePrice = double.tryParse(
              productData['Ppurchaseprice']?.toString() ?? '0',
            ) ?? 0;
            int qty = int.tryParse(
              item['qty']?.toString() ?? '0',
            ) ?? 0;
            totalCost += (purchasePrice * qty);
            break;
          }
        }
      }

      if (data['date'] is Timestamp) {
        DateTime saleDate = (data['date'] as Timestamp).toDate();
        if (saleDate.year == now.year && saleDate.month == now.month && saleDate.day == now.day) {
          _dashboardModels.todaySales += amount;
        }
      }
    }

    _dashboardModels.totalProfit = totalSales - totalCost;
    _dashboardModels.totalPurchase = 0;

    for (var purchase in _dashboardModels.purchaseDocs) {
      var data = purchase.data();
      double amount = double.tryParse(
        data['total']?.toString() ?? '0',
      ) ?? 0;
      _dashboardModels.totalPurchase += amount;
    }

    _dashboardModels.loading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    productSubscription?.cancel();
    saleSubscription?.cancel();
    purchaseSubscription?.cancel();
    super.dispose();
  }
}