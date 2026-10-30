import 'package:flutter/material.dart';
import '../models/addpro_models.dart';
import '../repository/addpro_repo.dart';

class AddproViewmodel extends ChangeNotifier {
  final AddproModels _addproModels = AddproModels();
  final AddproRepository _repository = AddproRepository();

  TextEditingController pname = TextEditingController();
  TextEditingController pcatogory = TextEditingController();
  TextEditingController punit = TextEditingController();
  TextEditingController pbarcode = TextEditingController();
  TextEditingController ppurchasePrice = TextEditingController();
  TextEditingController psellingprice = TextEditingController();
  TextEditingController pquantity = TextEditingController();
  TextEditingController pminstock = TextEditingController();
  TextEditingController psuppername = TextEditingController();
  TextEditingController pdate = TextEditingController();
  TextEditingController pinvoice = TextEditingController();
  TextEditingController pmrp = TextEditingController();

  String get selectedCategory => _addproModels.selectedCategory;
  String get selectedUnit => _addproModels.selectedUnit;
  get productImage => _addproModels.productImage;
  String get imageUrl => _addproModels.imageUrl;
  String get imageExtension => _addproModels.imageExtension;
  bool get loading => _addproModels.loading;

  void selectCategory(
      String value,
      ) {
    _addproModels.selectedCategory = value;
    pcatogory.text = value;
    notifyListeners();
  }

  void selectUnit(
      String value,
      ) {
    _addproModels.selectedUnit = value;
    punit.text = value;
    notifyListeners();
  }

  Future selectDate(
      BuildContext context,
      ) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
        2000,
      ),
      lastDate: DateTime(
        2100,
      ),
    );

    if (pickedDate != null) {
      pdate.text = "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
      notifyListeners();
    }
  }

  Future pickImage() async {
    var picked = await _repository.pickImage();
    if (picked != null) {
      _addproModels.productImage = await _repository.getImageBytes(
        picked,
      );
      _addproModels.imageExtension = _repository.getImageExtension(
        picked,
      );
      notifyListeners();
    }
  }

  Future uploadImage() async {
    if (_addproModels.productImage == null) return;
    _addproModels.imageUrl = await _repository.uploadImage(
      _addproModels.productImage!,
      _addproModels.imageExtension,
    );
  }

  Future add(
      BuildContext context,
      ) async {
    if (pname.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            "Please enter product name",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_addproModels.selectedCategory == "Select category") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            "Please select a category",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_addproModels.selectedUnit == "Select unit") {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            "Please select a unit",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (pbarcode.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            "Please enter barcode",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (psellingprice.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            "Please enter selling price",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (pquantity.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            "Please enter quantity",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _addproModels.loading = true;
    notifyListeners();

    try {
      if (_addproModels.productImage != null) {
        await uploadImage();
      }

      final data = {
        "pname": pname.text.trim(),
        "pcatogory": _addproModels.selectedCategory,
        "punits": _addproModels.selectedUnit,
        "pbarcode": pbarcode.text.trim(),
        "Ppurchaseprice": ppurchasePrice.text.trim(),
        "pselling price": psellingprice.text.trim(),
        "pquantity": pquantity.text.trim(),
        "pminstock": pminstock.text.trim(),
        "psuppername": psuppername.text.trim(),
        "pdate": pdate.text.trim(),
        "pinvoice": pinvoice.text.trim(),
        "pmrp": pmrp.text.trim(),
        "pimage": _addproModels.imageUrl,
      };

      await _repository.addProduct(
        data,
      );
    } finally {
      _addproModels.loading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    pname.dispose();
    pcatogory.dispose();
    punit.dispose();
    pbarcode.dispose();
    ppurchasePrice.dispose();
    psellingprice.dispose();
    pquantity.dispose();
    pminstock.dispose();
    psuppername.dispose();
    pdate.dispose();
    pinvoice.dispose();
    pmrp.dispose();
    super.dispose();
  }
}