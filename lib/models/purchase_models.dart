class PurchaseModels {
  List<Map<String, dynamic>> purchaseItems;
  DateTime? selectedPurchaseDate;
  String selectedCategory;
  String selectedUnit;

  PurchaseModels({
    List<Map<String, dynamic>>? purchaseItems,
    this.selectedPurchaseDate,
    this.selectedCategory = "Select category",
    this.selectedUnit = "Select unit",
  }) : purchaseItems = purchaseItems ?? [];
}