import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseServices {
  final CollectionReference<Map<String, dynamic>> purchase =
  FirebaseFirestore.instance.collection(
    'purchase',
  );

  final CollectionReference<Map<String, dynamic>> products =
  FirebaseFirestore.instance.collection(
    'productsdata',
  );

  Future<void> addPurchase(
      Map<String, dynamic> data,
      ) async {
    await purchase.add(
      data,
    );
  }

  Future<void> updateStock(
      List<Map<String, dynamic>> purchaseItems,
      String supplierName,
      String billNo,
      ) async {
    for (var item in purchaseItems) {
      var check = await products
          .where(
        'pbarcode',
        isEqualTo: item['barcode'],
      )
          .get();

      if (check.docs.isNotEmpty) {
        var product = check.docs.first;

        int oldQty = int.tryParse(
          product['pquantity'].toString(),
        ) ??
            0;

        int purchaseQty = int.tryParse(
          item['quantity'].toString(),
        ) ??
            0;

        int totalQty = oldQty + purchaseQty;

        await products.doc(product.id).update({
          'pquantity': totalQty.toString(),
          'Ppurchaseprice': item['purchaseprice'],
          'pselling price': item['sellingprice'],
          'pmrp': item['mrp'],
          'pminstock': item['minstock'],
        });
      } else {
        await products.add({
          'pname': item['productname'],
          'pcatogory': item['category'],
          'punits': item['unit'],
          'pbarcode': item['barcode'],
          'pquantity': item['quantity'],
          'Ppurchaseprice': item['purchaseprice'],
          'pselling price': item['sellingprice'],
          'pmrp': item['mrp'],
          'pminstock': item['minstock'],
          'psuppername': supplierName,
          'pinvoice': billNo,
          'pdate': FieldValue.serverTimestamp(),
        });
      }
    }
  }
}