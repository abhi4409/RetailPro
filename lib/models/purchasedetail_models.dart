class PurchaseDetailModels {
  Map<String, dynamic> data;
  List items;
  String date;

  PurchaseDetailModels({
    required this.data,
    List? items,
    this.date = "",
  }) : items = items ?? [];
}