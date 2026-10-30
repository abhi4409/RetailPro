import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Viewmodels/purchaselist_viewmodel.dart';
import 'purchase_view.dart';
import 'Purchasedetail.dart';

class Purch extends StatefulWidget {
  Purch({
    super.key,
  });

  @override
  State<Purch> createState() => _PurchState();
}

class _PurchState extends State<Purch> {
  @override
  Widget build(
      BuildContext context,
      ) {
    var provider = Provider.of<PurchaseListViewmodel>(
      context,
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Addpurdetail(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          "Purchases",
        ),
      ),
      body: provider.loading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    color: Colors.blue.shade50,
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Purchases",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "₹${provider.totalPurchase.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Total amount",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                    color: Colors.green.shade50,
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green.shade100,
                        child: Icon(
                          Icons.person,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Suppliers",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${provider.suppliers.length}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Active",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.purple.shade100,
                        child: Icon(
                          Icons.date_range,
                          color: Colors.purple,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Last purchase",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        provider.lastDate,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${provider.lastPurchaseItems} items",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: (value) {
              provider.searchPurchase(
                value,
              );
            },
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
              ),
              hintText: "Search by supplier name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          provider.filteredDocs.isEmpty
              ? Padding(
            padding: EdgeInsets.only(
              top: 40,
            ),
            child: Center(
              child: Text(
                "No purchases found",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          )
              : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: provider.filteredDocs.length,
            itemBuilder: (context, index) {
              final data = provider.filteredDocs[index].data();

              String supplier = data['suppliername']?.toString() ??
                  "Unknown Supplier";

              String date = "No date";

              if (data['date'] is Timestamp) {
                DateTime purchaseDate =
                (data['date'] as Timestamp).toDate();

                date =
                "${purchaseDate.day}/${purchaseDate.month}/${purchaseDate.year}";
              }

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PurchaseDetail(
                        data: data,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
                  margin: EdgeInsets.only(
                    bottom: 10,
                  ),
                  color: Colors.blue.shade50,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(
                        Icons.local_shipping_sharp,
                        color: Colors.blue,
                      ),
                    ),
                    title: Text(
                      supplier,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Date: $date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}