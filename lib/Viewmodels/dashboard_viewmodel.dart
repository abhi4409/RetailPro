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
  List<Map<String, dynamic>> get lowStockProducts =>
      _dashboardModels.lowStockProducts;
  bool get loading => _dashboardModels.loading;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> get productDocs =>
      _dashboardModels.productDocs;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> get saleDocs =>
      _dashboardModels.saleDocs;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> get purchaseDocs =>
      _dashboardModels.purchaseDocs;

  bool get productLoaded => _dashboardModels.productLoaded;
  bool get saleLoaded => _dashboardModels.saleLoaded;
  bool get purchaseLoaded => _dashboardModels.purchaseLoaded;

  void getDashboardData() {
    productSubscription = _repository.getProducts().listen(
          (snapshot) {
        _dashboardModels.productDocs = snapshot.docs;
        _dashboardModels.productLoaded = true;

        calculateDashboard();
      },
    );

    saleSubscription = _repository.getSales().listen(
          (snapshot) {
        _dashboardModels.saleDocs = snapshot.docs;
        _dashboardModels.saleLoaded = true;

        calculateDashboard();
      },
    );

    purchaseSubscription = _repository.getPurchases().listen(
          (snapshot) {
        _dashboardModels.purchaseDocs = snapshot.docs;
        _dashboardModels.purchaseLoaded = true;

        calculateDashboard();
      },
    );
  }

  bool isCurrentMonth(
      dynamic dateValue,
      ) {
    DateTime? date;

    if (dateValue is Timestamp) {
      date = dateValue.toDate();
    } else if (dateValue is DateTime) {
      date = dateValue;
    } else if (dateValue != null) {
      String value = dateValue.toString().trim();

      DateTime? parsedDate = DateTime.tryParse(
        value,
      );

      if (parsedDate != null) {
        date = parsedDate;
      } else {
        List<String> parts = value.split(
          '/',
        );

        if (parts.length == 3) {
          int? day = int.tryParse(
            parts[0],
          );

          int? month = int.tryParse(
            parts[1],
          );

          int? year = int.tryParse(
            parts[2],
          );

          if (day != null &&
              month != null &&
              year != null) {
            date = DateTime(
              year,
              month,
              day,
            );
          }
        }
      }
    }

    if (date == null) {
      return false;
    }

    DateTime now = DateTime.now();

    return date.year == now.year &&
        date.month == now.month;
  }

  void calculateDashboard() {
    if (!_dashboardModels.productLoaded ||
        !_dashboardModels.saleLoaded ||
        !_dashboardModels.purchaseLoaded) {
      return;
    }

    _dashboardModels.productCount =
        _dashboardModels.productDocs.length;

    _dashboardModels.lowStockProducts = [];

    for (var product in _dashboardModels.productDocs) {
      var data = product.data();

      double quantity = double.tryParse(
        data['pquantity']?.toString() ?? '0',
      ) ??
          0.0;

      double minStock = double.tryParse(
        data['pminstock']?.toString() ?? '0',
      ) ??
          0.0;

      if (quantity <= minStock) {
        _dashboardModels.lowStockProducts.add(
          data,
        );
      }
    }

    double monthlySales = 0.0;
    double monthlyCost = 0.0;

    for (var sale in _dashboardModels.saleDocs) {
      var data = sale.data();

      if (!isCurrentMonth(
        data['date'],
      )) {
        continue;
      }

      double amount = double.tryParse(
        data['totalAmount']?.toString() ?? '0',
      ) ??
          0.0;

      monthlySales =
          monthlySales + amount;

      List items =
      data['items'] is List
          ? data['items']
          : [];

      for (var item in items) {
        for (var product
        in _dashboardModels.productDocs) {
          if (product.id ==
              item['id']?.toString()) {
            var productData =
            product.data();

            double purchasePrice =
                double.tryParse(
                  productData['Ppurchaseprice']
                      ?.toString() ??
                      '0',
                ) ??
                    0.0;

            double qty =
                double.tryParse(
                  item['qty']
                      ?.toString() ??
                      '0',
                ) ??
                    0.0;

            monthlyCost =
                monthlyCost +
                    (purchasePrice * qty);

            break;
          }
        }
      }
    }

    _dashboardModels.todaySales =
        monthlySales;

    _dashboardModels.totalProfit =
        monthlySales - monthlyCost;

    _dashboardModels.totalPurchase = 0.0;

    for (var purchase
    in _dashboardModels.purchaseDocs) {
      var data = purchase.data();

      if (!isCurrentMonth(
        data['date'],
      )) {
        continue;
      }

      double amount = double.tryParse(
        data['total']?.toString() ?? '0',
      ) ??
          0.0;

      _dashboardModels.totalPurchase =
          _dashboardModels.totalPurchase +
              amount;
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