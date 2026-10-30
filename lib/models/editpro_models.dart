import 'dart:typed_data';

class EditproModels {
  String selectedCategory;
  String selectedUnit;
  String existingImageUrl;
  Uint8List? newProductImage;
  String imageExtension;
  String docid;

  EditproModels({
    this.selectedCategory = "Select category",
    this.selectedUnit = "Select unit",
    this.existingImageUrl = "",
    this.newProductImage,
    this.imageExtension = "jpg",
    this.docid = "",
  });
}