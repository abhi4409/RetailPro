import 'package:flutter/material.dart';
import '../models/Billinggenrate_model.dart';
import '../repository/Billinggenrate_repository.dart';
class BillinggenerateViewmodel extends ChangeNotifier {
  late BillinggenerateModels _billinggenerateModels;

  final BillinggenerateRepository _repository = BillinggenerateRepository();

  BillinggenerateViewmodel({
    required String customerName,
    required String billNo,
    required String customerMobile,
    required List<Map<String, dynamic>> cart,
    required double totalAmount,
    required String paymentMethod,
  }) {
    _billinggenerateModels = BillinggenerateModels(
      customerName: customerName,
      billNo: billNo,
      customerMobile: customerMobile,
      cart: List<Map<String, dynamic>>.from(cart),
      totalAmount: totalAmount,
      paymentMethod: paymentMethod,
    );
  }

  String get customerName => _billinggenerateModels.customerName;

  String get billNo => _billinggenerateModels.billNo;

  String get customerMobile => _billinggenerateModels.customerMobile;

  List<Map<String, dynamic>> get cart => _billinggenerateModels.cart;

  double get totalAmount => _billinggenerateModels.totalAmount;

  String get paymentMethod => _billinggenerateModels.paymentMethod;

  DateTime get now => _billinggenerateModels.now;

  String get customerDisplayName => _repository.getCustomerDisplayName(
    _billinggenerateModels.customerName,
  );

  double getPrice(Map<String, dynamic> item) {
    return _repository.getPrice(item);
  }

  int getQty(Map<String, dynamic> item) {
    return _repository.getQty(item);
  }

  double getAmount(Map<String, dynamic> item) {
    return _repository.getAmount(item);

  }
}