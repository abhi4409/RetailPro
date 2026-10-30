class BillinggenerateServices {
  String getCustomerDisplayName(
      String customerName,
      ) {
    return customerName.isEmpty ? "Walk in customer" : customerName;
  }

  double getPrice(
      Map<String, dynamic> item,
      ) {
    return double.tryParse(
      item['price'].toString(),
    ) ?? 0;
  }

  int getQty(
      Map<String, dynamic> item,
      ) {
    return int.tryParse(
      item['qty'].toString(),
    ) ?? 0;
  }

  double getAmount(
      Map<String, dynamic> item,
      ) {
    return getPrice(
      item,
    ) * getQty(
      item,
    );
  }
}