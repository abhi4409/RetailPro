import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/purchase_models.dart';
import '../repository/purchase_repo.dart';
class PurchaseViewmodel extends ChangeNotifier {
  final PurchaseModels _purchaseModels = PurchaseModels();
  final PurchaseRepository _repository = PurchaseRepository();

  TextEditingController billno = TextEditingController();
  TextEditingController suppliername = TextEditingController();
  TextEditingController productname = TextEditingController();
  TextEditingController suppliermob = TextEditingController();
  TextEditingController barcode = TextEditingController();
  TextEditingController qty = TextEditingController();
  TextEditingController purprice = TextEditingController();
  TextEditingController mrp = TextEditingController();
  TextEditingController sellingprice = TextEditingController();
  TextEditingController minstock = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController purchasedate = TextEditingController();
  TextEditingController totalamount = TextEditingController();

  List<Map<String, dynamic>> get purchaseItems =>
      _purchaseModels.purchaseItems;

  DateTime? get selectedPurchaseDate =>
      _purchaseModels.selectedPurchaseDate;

  String get selectedCategory => _purchaseModels.selectedCategory;

  String get selectedUnit => _purchaseModels.selectedUnit;

  void categorySelect(String value) {
    _purchaseModels.selectedCategory = value;
    notifyListeners();
  }

  void unitSelect(String value) {
    _purchaseModels.selectedUnit = value;
    notifyListeners();
  }

  void addProduct() {
    if (productname.text.isEmpty) {
      return;
    }

    _purchaseModels.purchaseItems.add({
      "productname": productname.text,
      "barcode": barcode.text,
      "quantity": qty.text,
      "purchaseprice": purprice.text,
      "mrp": mrp.text,
      "sellingprice": sellingprice.text,
      "minstock": minstock.text,
      "category": _purchaseModels.selectedCategory,
      "unit": _purchaseModels.selectedUnit,
    });

    productname.clear();
    barcode.clear();
    qty.clear();
    purprice.clear();
    mrp.clear();
    sellingprice.clear();
    minstock.clear();

    _purchaseModels.selectedCategory = "Select category";
    _purchaseModels.selectedUnit = "Select unit";

    notifyListeners();
  }

  Future updateStock() async {
    await _repository.updateStock(
      _purchaseModels.purchaseItems,
      suppliername.text,
      billno.text,
    );
  }

  Future addPurchase(BuildContext context) async {
    if (productname.text.isNotEmpty) {
      _purchaseModels.purchaseItems.add({
        "productname": productname.text,
        "barcode": barcode.text,
        "quantity": qty.text,
        "purchaseprice": purprice.text,
        "mrp": mrp.text,
        "sellingprice": sellingprice.text,
        "minstock": minstock.text,
        "category": _purchaseModels.selectedCategory,
        "unit": _purchaseModels.selectedUnit,
      });
    }

    if (_purchaseModels.purchaseItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please add product",
          ),
        ),
      );
      return;
    }

    final data = {
      "billno": billno.text,
      "suppliername": suppliername.text,
      "suppliermobile": suppliermob.text,
      "items": _purchaseModels.purchaseItems,
      "notes": notes.text,
      "total": double.tryParse(totalamount.text) ?? 0,
      "date": Timestamp.fromDate(
        _purchaseModels.selectedPurchaseDate ?? DateTime.now(),
      ),
    };

    await _repository.addPurchase(data);
    await updateStock();

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Purchase saved successfully",
        ),
        backgroundColor: Colors.green,
      ),
    );

    billno.clear();
    suppliername.clear();
    suppliermob.clear();
    productname.clear();
    barcode.clear();
    qty.clear();
    purprice.clear();
    mrp.clear();
    sellingprice.clear();
    minstock.clear();
    notes.clear();
    purchasedate.clear();
    totalamount.clear();

    _purchaseModels.purchaseItems.clear();
    _purchaseModels.selectedPurchaseDate = null;
    _purchaseModels.selectedCategory = "Select category";
    _purchaseModels.selectedUnit = "Select unit";

    notifyListeners();
  }

  Future selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
      _purchaseModels.selectedPurchaseDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _purchaseModels.selectedPurchaseDate = pickedDate;
      purchasedate.text =
      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      notifyListeners();
    }
  }

  @override
  void dispose() {
    billno.dispose();
    suppliername.dispose();
    productname.dispose();
    suppliermob.dispose();
    barcode.dispose();
    qty.dispose();
    purprice.dispose();
    mrp.dispose();
    sellingprice.dispose();
    minstock.dispose();
    notes.dispose();
    purchasedate.dispose();
    totalamount.dispose();
    super.dispose();
  }
}