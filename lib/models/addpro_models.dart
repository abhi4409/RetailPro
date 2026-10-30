import 'dart:typed_data';

class AddproModels {
  String selectedCategory;
  String selectedUnit;
  Uint8List? productImage;
  String imageUrl;
  String imageExtension;
  bool loading;

  AddproModels({
    this.selectedCategory = "Select category",
    this.selectedUnit = "Select unit",
    this.productImage,
    this.imageUrl = "",
    this.imageExtension = "jpg",
    this.loading = false,
  });
}