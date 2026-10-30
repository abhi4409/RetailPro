import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseDetailServices {
  List getItems(
      Map<String, dynamic> data,
      ) {
    return data['items'] ?? [];
  }
  String getDate(
      Map<String, dynamic> data,
      ) {
    if (data['date'] != null &&
        data['date'] is Timestamp) {
      DateTime d =
      (data['date'] as Timestamp)
          .toDate();
      return "${d.day}/${d.month}/${d.year}";
    }

    return "";
  }
}