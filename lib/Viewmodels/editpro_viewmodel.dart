import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/editpro_models.dart';
import '../repository/editpro_repo.dart';

class EditproViewmodel extends ChangeNotifier {
  final EditproModels _editproModels = EditproModels();
  final EditproRepository _repository = EditproRepository();

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

  EditproViewmodel(
      Map args,
      ) {
    loadData(
      args,
    );
  }

  String get selectedCategory => _editproModels.selectedCategory;
  String get selectedUnit => _editproModels.selectedUnit;
  String get existingImageUrl => _editproModels.existingImageUrl;
  Uint8List? get newProductImage => _editproModels.newProductImage;
  String get imageExtension => _editproModels.imageExtension;
  String get docid => _editproModels.docid;

  void loadData(
      Map args,
      ) {
    pname.text = args["PNAME"]?.toString() ?? "";
    pcatogory.text = args["PCATEGORY"]?.toString() ?? "";
    _editproModels.selectedCategory = args["PCATEGORY"]?.toString() ?? "Select category";
    punit.text = args["PUNIT"]?.toString() ?? "";
    _editproModels.selectedUnit = args["PUNIT"]?.toString() ?? "Select unit";
    pbarcode.text = args["PBARCODE"]?.toString() ?? "";
    ppurchasePrice.text = args["PPURCHASEPRICE"]?.toString() ?? "";
    psellingprice.text = args["PSELLINGPRICE"]?.toString() ?? "";
    pquantity.text = args["PQUANTITY"]?.toString() ?? "";
    pminstock.text = args["PMINSTOCK"]?.toString() ?? "";
    psuppername.text = args["PSUPPLIERNAME"]?.toString() ?? "";
    pinvoice.text = args["PINVOICE"]?.toString() ?? "";
    _editproModels.existingImageUrl = args["PIMAGE"]?.toString() ?? "";
    _editproModels.docid = args["docid"]?.toString() ?? "";

    var dateValue = args["PDATE"];
    if (dateValue is Timestamp) {
      DateTime date = dateValue.toDate();
      pdate.text = "${date.day}/${date.month}/${date.year}";
    } else {
      pdate.text = dateValue?.toString() ?? "";
    }
  }

  void selectCategory(
      String value,
      ) {
    _editproModels.selectedCategory = value;
    pcatogory.text = value;
    notifyListeners();
  }

  void selectUnit(
      String value,
      ) {
    _editproModels.selectedUnit = value;
    punit.text = value;
    notifyListeners();
  }

  Future pickImage() async {
    var picked = await _repository.pickImage();
    if (picked != null) {
      _editproModels.newProductImage = await _repository.getImageBytes(
        picked,
      );
      _editproModels.imageExtension = _repository.getImageExtension(
        picked,
      );
      notifyListeners();
    }
  }

  Future<String> uploadImage() async {
    if (_editproModels.newProductImage == null) {
      return _editproModels.existingImageUrl;
    }
    return await _repository.uploadImage(
      _editproModels.newProductImage!,
      _editproModels.imageExtension,
    );
  }

  Future editdata() async {
    String finalImage = _editproModels.existingImageUrl;
    if (_editproModels.newProductImage != null) {
      finalImage = await uploadImage();
    }

    final data = {
      "pname": pname.text,
      "pcatogory": _editproModels.selectedCategory,
      "punits": _editproModels.selectedUnit,
      "pbarcode": pbarcode.text,
      "Ppurchaseprice": ppurchasePrice.text,
      "pselling price": psellingprice.text,
      "pquantity": pquantity.text,
      "pminstock": pminstock.text,
      "psuppername": psuppername.text,
      "pdate": pdate.text,
      "pinvoice": pinvoice.text,
      "pimage": finalImage,
    };

    await _repository.updateProduct(
      _editproModels.docid,
      data,
    );
  }

  Future selectDate(
      BuildContext context,
      ) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
        2020,
      ),
      lastDate: DateTime(
        2035,
      ),
    );

    if (pickedDate != null) {
      pdate.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
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
    super.dispose();
  }
}