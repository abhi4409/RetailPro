import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddtobillViewmodel extends ChangeNotifier {
  final CollectionReference products =
  FirebaseFirestore.instance.collection('productsdata');

  final CollectionReference billCounter =
  FirebaseFirestore.instance.collection('counters');

  TextEditingController cusname = TextEditingController();
  TextEditingController cusnum = TextEditingController();

  String selectedcustomer = "walk in customer";
  String searchText = "";

  bool loading = false;

  List<QueryDocumentSnapshot> allProducts = [];
  List<QueryDocumentSnapshot> filteredProducts = [];

  List<Map<String, dynamic>> cart = [];

  AddtobillViewmodel() {
    getProducts();
  }

  Future<void> getProducts() async {
    try {
      loading = true;
      notifyListeners();

      var snapshot = await products.get();

      allProducts = snapshot.docs;
      filteredProducts = snapshot.docs;
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void searchProduct(String value) {
    searchText = value;

    filteredProducts = allProducts.where((doc) {
      String productName =
      doc['pname'].toString().toLowerCase();

      return productName.contains(
        searchText.toLowerCase(),
      );
    }).toList();

    notifyListeners();
  }

  void changeCustomer(String value) {
    selectedcustomer = value;

    notifyListeners();
  }

  void addtocart(
      String id,
      String name,
      String price,
      String unit,
      String mrp,
      ) {
    int index = cart.indexWhere(
          (item) => item['id'] == id,
    );

    if (index != -1) {
      int qty =
          int.tryParse(
            cart[index]['qty'].toString(),
          ) ??
              0;

      cart[index]['qty'] = qty + 1;
    } else {
      cart.add({
        'id': id,
        'name': name,
        'price': price,
        'unit': unit,
        'qty': 1,
        'mrp': mrp,
      });
    }

    notifyListeners();
  }

  void increseqty(int index) {
    int qty =
        int.tryParse(
          cart[index]['qty'].toString(),
        ) ??
            0;

    cart[index]['qty'] = qty + 1;

    notifyListeners();
  }

  void decreseqty(int index) {
    int qty =
        int.tryParse(
          cart[index]['qty'].toString(),
        ) ??
            0;

    if (qty > 1) {
      cart[index]['qty'] = qty - 1;
    }

    notifyListeners();
  }

  void itemdelete(int index) {
    cart.removeAt(index);

    notifyListeners();
  }

  void clearcart() {
    cart.clear();

    notifyListeners();
  }

  double get totalAmount {
    double total = 0;

    for (var item in cart) {
      double price =
          double.tryParse(
            item['price'].toString(),
          ) ??
              0;

      int qty =
          int.tryParse(
            item['qty'].toString(),
          ) ??
              0;

      total = total + (price * qty);
    }

    return total;
  }

  Future<String> getBillNumber() async {
    var reference =
    billCounter.doc('bill');

    var doc =
    await reference.get();

    int number = 1;

    if (doc.exists) {
      var data =
      doc.data() as Map<String, dynamic>?;

      int lastNumber =
          int.tryParse(
            data?['lastNumber']
                ?.toString() ??
                "0",
          ) ??
              0;

      number = lastNumber + 1;

      await reference.update({
        'lastNumber': number,
      });
    } else {
      await reference.set({
        'lastNumber': number,
      });
    }

    return "RP-$number";
  }

  void newBill() {
    cart.clear();

    cusname.clear();

    cusnum.clear();

    searchText = "";

    selectedcustomer =
    "walk in customer";

    filteredProducts =
        List.from(allProducts);

    notifyListeners();
  }

  @override
  void dispose() {
    cusname.dispose();
    cusnum.dispose();

    super.dispose();
  }
}