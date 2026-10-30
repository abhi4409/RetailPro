import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Viewmodels/addpro_viewmodel.dart';
import '../home/Bottonnavi.dart';

class Addp extends StatefulWidget {
  Addp({
    super.key,
  });

  @override
  State<Addp> createState() => _AddpState();
}

class _AddpState extends State<Addp> {
  @override
  Widget build(
      BuildContext context,
      ) {
    return ChangeNotifierProvider(
      create: (context,) => AddproViewmodel(),
      child: Consumer<AddproViewmodel>(
        builder: (
            context,
            provider,
            child,
            ) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text(
                "add products",
              ),
            ),
            body: ListView(
              children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      await provider.pickImage();
                    },
                    child: Container(
                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: provider.productImage == null
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_photo_alternate,
                            size: 45,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Pick Product Image",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        child: Image.memory(
                          provider.productImage!,
                          width: double.infinity,
                          height: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: TextField(
                    controller: provider.pname,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.inventory_2,
                      ),
                      labelText: "enter product name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: PopupMenuButton<String>(
                          onSelected: (
                              value,
                              ) {
                            provider.selectCategory(
                              value,
                            );
                          },
                          itemBuilder: (
                              context,
                              ) => [
                            PopupMenuItem(
                              value: "Grocery",
                              child: Text(
                                "Grocery",
                              ),
                            ),
                            PopupMenuItem(
                              value: "Beverages",
                              child: Text(
                                "Beverages",
                              ),
                            ),
                            PopupMenuItem(
                              value: "Snacks",
                              child: Text(
                                "Snacks",
                              ),
                            ),
                            PopupMenuItem(
                              value: "Dairy",
                              child: Text(
                                "Dairy",
                              ),
                            ),
                            PopupMenuItem(
                              value: "Bakery",
                              child: Text(
                                "Bakery",
                              ),
                            ),
                            PopupMenuItem(
                              value: "Fruits",
                              child: Text(
                                "Fruits",
                              ),
                            ),
                            PopupMenuItem(
                              value: "Vegetables",
                              child: Text(
                                "Vegetables",
                              ),
                            ),
                            PopupMenuItem(
                              value: "Personal Care",
                              child: Text(
                                "Personal Care",
                              ),
                            ),
                            PopupMenuItem(
                              value: "Household",
                              child: Text(
                                "Household",
                              ),
                            ),
                            PopupMenuItem(
                              value: "Others",
                              child: Text(
                                "Others",
                              ),
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
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: PopupMenuButton<String>(
                          onSelected: (
                              value,
                              ) {
                            provider.selectUnit(
                              value,
                            );
                          },
                          itemBuilder: (
                              context,
                              ) => [
                            PopupMenuItem(
                              value: "KG",
                              child: Text(
                                "KG",
                              ),
                            ),
                            PopupMenuItem(
                              value: "Gram",
                              child: Text(
                                "Gram",
                              ),
                            ),
                            PopupMenuItem(
                              value: "Liter",
                              child: Text(
                                "Liter",
                              ),
                            ),
                            PopupMenuItem(
                              value: "Piece",
                              child: Text(
                                "Piece",
                              ),
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
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: TextField(
                    controller: provider.pbarcode,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.qr_code_scanner,
                      ),
                      labelText: "barcode",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: TextField(
                    controller: provider.pmrp,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.currency_rupee,
                      ),
                      labelText: "Mrp",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: TextField(
                          controller: provider.ppurchasePrice,
                          decoration: InputDecoration(
                            labelText: "purchase price",
                            prefixIcon: Icon(
                              Icons.currency_rupee,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: TextField(
                          controller: provider.psellingprice,
                          decoration: InputDecoration(
                            labelText: "selling price",
                            prefixIcon: Icon(
                              Icons.currency_rupee,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: TextField(
                          controller: provider.pquantity,
                          decoration: InputDecoration(
                            labelText: "Quantity",
                            prefixIcon: Icon(
                              Icons.inventory_2,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: TextField(
                          controller: provider.pminstock,
                          decoration: InputDecoration(
                            labelText: "minmumum stock",
                            prefixIcon: Icon(
                              Icons.warning,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: TextField(
                    controller: provider.psuppername,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      labelText: "supplier name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: TextField(
                          controller: provider.pinvoice,
                          decoration: InputDecoration(
                            labelText: "bill invoice NO",
                            prefixIcon: Icon(
                              Icons.receipt,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: TextField(
                          controller: provider.pdate,
                          readOnly: true,
                          onTap: () async {
                            await provider.selectDate(
                              context,
                            );
                          },
                          decoration: InputDecoration(
                            labelText: "added date",
                            prefixIcon: Icon(
                              Icons.date_range,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
                ElevatedButton(
                  onPressed: provider.loading
                      ? null
                      : () async {
                    try {
                      await provider.add(
                        context,
                      );
                      if (!context.mounted) {
                        return;
                      }
                      if (provider.pname.text.trim().isNotEmpty &&
                          provider.pbarcode.text.trim().isNotEmpty &&
                          provider.psellingprice.text.trim().isNotEmpty &&
                          provider.pquantity.text.trim().isNotEmpty &&
                          provider.selectedCategory != "Select category" &&
                          provider.selectedUnit != "Select unit") {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Product added successfully",
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (
                                context,
                                ) => Bottomna(),
                          ),
                        );
                      }
                    } catch (e) {
                      if (!context.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Product adding failed $e",
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.blue,
                    ),
                  ),
                  child: Text(
                    provider.loading
                        ? "ADDING..."
                        : "ADD PRODUCT",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}