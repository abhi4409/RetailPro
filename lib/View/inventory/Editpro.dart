import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Viewmodels/editpro_viewmodel.dart';

class Editp extends StatefulWidget {
  Editp({
    super.key,
  });

  @override
  State<Editp> createState() => _EditpState();
}

class _EditpState extends State<Editp> {
  @override
  Widget build(
      BuildContext context,
      ) {
    final args = ModalRoute.of(
      context,
    )!.settings.arguments as Map;

    return ChangeNotifierProvider(
      create: (
          context,
          ) => EditproViewmodel(
        args,
      ),
      child: Consumer<EditproViewmodel>(
        builder: (
            context,
            provider,
            child,
            ) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text(
              "Edit product details",
            ),
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: GestureDetector(
                  onTap: () async {
                    await provider.pickImage();
                  },
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: provider.newProductImage != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.memory(
                            provider.newProductImage!,
                            fit: BoxFit.cover,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              color: Colors.black54,
                              padding: EdgeInsets.all(
                                5,
                              ),
                              child: Text(
                                "Change Product Image",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        : provider.existingImageUrl.isNotEmpty
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            provider.existingImageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (
                                context,
                                error,
                                stackTrace,
                                ) => Icon(
                              Icons.inventory_2,
                              size: 50,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              color: Colors.black54,
                              padding: EdgeInsets.all(
                                5,
                              ),
                              child: Text(
                                "Change Product Image",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        : Column(
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
                          "Change Product Image",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
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
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
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
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
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
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: TextField(
                        controller: provider.pdate,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "added date",
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.calendar_month,
                            ),
                            onPressed: () async {
                              await provider.selectDate(
                                context,
                              );
                            },
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
                onPressed: () async {
                  try {
                    await provider.editdata();
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Product updated successfully",
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(
                      context,
                    );
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Product update failed $e",
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
                  "Edit product",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}