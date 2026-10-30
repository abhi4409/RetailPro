import 'package:flutter/material.dart';
import '../models/Detailbill_model.dart';
import '../repository/Detailbill_repository.dart';
class DetailbillViewmodel extends ChangeNotifier {
  late DetailbillModels _detailbillModels;
  final DetailbillRepository _repository = DetailbillRepository();

  DetailbillViewmodel({
    required dynamic snap,
  }) {
    _detailbillModels = DetailbillModels(
      snap: snap,
    );
  }

  dynamic get snap => _detailbillModels.snap;

  List get items => _repository.getItems(
    _detailbillModels.snap,
  );

  String get billNo => _repository.getBillNo(
    _detailbillModels.snap,
  );

  String get paymentMethod => _repository.getPaymentMethod(
    _detailbillModels.snap,
  );

  String get customerName => _repository.getCustomerName(
    _detailbillModels.snap,
  );

  String get customerMobile => _repository.getCustomerMobile(
    _detailbillModels.snap,
  );

  String get totalAmount => _repository.getTotalAmount(
    _detailbillModels.snap,
  );

  double getPrice(
      dynamic item,
      ) => _repository.getPrice(
    item,
  );

  int getQty(
      dynamic item,
      ) => _repository.getQty(
    item,
  );

  double getAmount(
      dynamic item,
      ) => _repository.getAmount(
    item,
  );

  String get billDate => _repository.getBillDate(
    _detailbillModels.snap,
  );

  String get billTime => _repository.getBillTime(
    _detailbillModels.snap,
  );
}