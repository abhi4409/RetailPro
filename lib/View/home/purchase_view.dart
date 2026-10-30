import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Viewmodels/purchase_viewmodel.dart';

class Addpurdetail extends StatefulWidget {
  Addpurdetail({
    super.key,
  });

  @override
  State<Addpurdetail> createState() => _AddpurdetailState();
}

class _AddpurdetailState extends State<Addpurdetail> {
  @override
  Widget build(
      BuildContext context,
      ) {
    var provider = Provider.of<PurchaseViewmodel>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Purchase Details",
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(
          12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  20,
                ),
                border: Border.all(
                  color: Colors.grey.shade400,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(
                          Icons.store,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Supplier Information",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Supplier Name",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: provider.suppliername,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                  ),
                                  hintText: "Enter supplier name",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Supplier Mobile",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: provider.suppliermob,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone,
                                  ),
                                  hintText: "Enter mobile no",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Invoice / Bill No",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: provider.billno,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.receipt,
                                  ),
                                  hintText: "Enter invoice number",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Purchase Date",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: provider.purchasedate,
                                readOnly: true,
                                onTap: () {
                                  provider.selectDate(
                                    context,
                                  );
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.calendar_month,
                                  ),
                                  hintText: "Select date",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  20,
                ),
                border: Border.all(
                  color: Colors.grey.shade400,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.indigo.shade100,
                        child: Icon(
                          Icons.inventory_2,
                          color: Colors.indigo,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Product Details",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: provider.productname,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.inventory_2,
                            ),
                            hintText: "Enter product name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Category",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              PopupMenuButton<String>(
                                onSelected: (value) {
                                  provider.categorySelect(
                                    value,
                                  );
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: "Grocery",
                                    child: Text("Grocery"),
                                  ),
                                  PopupMenuItem(
                                    value: "Beverages",
                                    child: Text("Beverages"),
                                  ),
                                  PopupMenuItem(
                                    value: "Snacks",
                                    child: Text("Snacks"),
                                  ),
                                  PopupMenuItem(
                                    value: "Dairy",
                                    child: Text("Dairy"),
                                  ),
                                  PopupMenuItem(
                                    value: "Bakery",
                                    child: Text("Bakery"),
                                  ),
                                  PopupMenuItem(
                                    value: "Fruits",
                                    child: Text("Fruits"),
                                  ),
                                  PopupMenuItem(
                                    value: "Vegetables",
                                    child: Text("Vegetables"),
                                  ),
                                  PopupMenuItem(
                                    value: "Personal Care",
                                    child: Text("Personal Care"),
                                  ),
                                  PopupMenuItem(
                                    value: "Household",
                                    child: Text("Household"),
                                  ),
                                  PopupMenuItem(
                                    value: "Others",
                                    child: Text("Others"),
                                  ),
                                ],
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.category,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          provider.selectedCategory,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Barcode",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: provider.barcode,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.qr_code_scanner,
                                  ),
                                  hintText: "Enter barcode",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Unit",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              PopupMenuButton<String>(
                                onSelected: (value) {
                                  provider.unitSelect(
                                    value,
                                  );
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: "KG",
                                    child: Text("KG"),
                                  ),
                                  PopupMenuItem(
                                    value: "Gram",
                                    child: Text("Gram"),
                                  ),
                                  PopupMenuItem(
                                    value: "Liter",
                                    child: Text("Liter"),
                                  ),
                                  PopupMenuItem(
                                    value: "Piece",
                                    child: Text("Piece"),
                                  ),
                                ],
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.layers_rounded,
                                    ),
                                    border: OutlineInputBorder(),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          provider.selectedUnit,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Quantity",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: provider.qty,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.inventory,
                                  ),
                                  hintText: "Enter quantity",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Purchase Price",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: provider.purprice,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.currency_rupee,
                                  ),
                                  hintText: "Purchase price",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "MRP",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: provider.mrp,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.currency_rupee,
                                  ),
                                  hintText: "Enter MRP",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Selling Price",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: provider.sellingprice,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.currency_rupee,
                                  ),
                                  hintText: "Selling price",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Min Stock",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: provider.minstock,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.warning,
                                  ),
                                  hintText: "Min stock",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  20,
                ),
                border: Border.all(
                  color: Colors.grey.shade400,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(
                          Icons.calculate,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Total Amount",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: TextField(
                      controller: provider.totalamount,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.currency_rupee,
                        ),
                        hintText: "Enter total purchase amount",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  20,
                ),
                border: Border.all(
                  color: Colors.grey.shade400,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.orange.shade100,
                        child: Icon(
                          Icons.note,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Notes",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: TextField(
                      controller: provider.notes,
                      maxLines: 2,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.note_alt_rounded,
                        ),
                        hintText: "Add any additional notes",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: () {
                  provider.addProduct();
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.blue,
                ),
                label: Text(
                  "Add Another Product",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                onPressed: () async {
                  await provider.addPurchase(
                    context,
                  );
                },
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                label: Text(
                  "Save Purchase",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}