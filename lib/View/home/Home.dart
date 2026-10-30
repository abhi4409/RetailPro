import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Viewmodels/dashboard_viewmodel.dart';
import '../profile/Approvestaff.dart';
import '../profile/Profile.dart';
import '../sales/Addtobill_view.dart';
import 'Purchase.dart';

class Hom extends StatefulWidget {
  Hom({
    super.key,
  });

  @override
  State<Hom> createState() => _HomState();
}

class _HomState extends State<Hom> {
  @override
  Widget build(
      BuildContext context,
      ) {
    var provider = Provider.of<DashboardViewmodel>(
      context,
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Row(
            children: [
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
                child: Icon(
                  Icons.storefront,
                  size: 32,
                  color: Colors.blue,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to retail pro",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Manage your shop and grow your business",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (
                        context,
                        ) => Prof(),
                  ),
                );
              },
              icon: Icon(
                Icons.person,
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: provider.loading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Dashboard",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 150,
                    width: 180,
                    child: Card(
                      color: Colors.blue.shade50,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          CircleAvatar(
                            child: Icon(
                              Icons.inventory_2,
                              size: 30,
                              color: Colors.blue,
                            ),
                            backgroundColor: Colors.blue.shade100,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${provider.productCount}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Products",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    width: 180,
                    child: Card(
                      color: Colors.green.shade50,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          CircleAvatar(
                            child: Icon(
                              Icons.currency_rupee,
                              size: 30,
                              color: Colors.green,
                            ),
                            backgroundColor: Colors.green.shade100,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "₹${provider.todaySales.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Todays Sales",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 150,
                    width: 180,
                    child: Card(
                      color: Colors.orange.shade50,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          CircleAvatar(
                            child: Icon(
                              Icons.shopping_cart,
                              size: 30,
                              color: Colors.orange,
                            ),
                            backgroundColor: Colors.orange.shade100,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "₹${provider.totalPurchase.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Purchases",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    width: 180,
                    child: Card(
                      color: Colors.red.shade50,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          CircleAvatar(
                            child: Icon(
                              Icons.trending_up,
                              size: 30,
                              color: Colors.red,
                            ),
                            backgroundColor: Colors.red.shade100,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "₹${provider.totalProfit.toStringAsFixed(2)}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Profit",
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.blueAccent,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (
                                    context,
                                    ) => StaffApproval(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.verified_user,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Approve Staff",
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.amber,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (
                                    context,
                                    ) => Addpbill(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.point_of_sale,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "New Sale",
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.cyan,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (
                                    context,
                                    ) => Purch(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.shopping_cart,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Purchase",
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Low stock alerts",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                provider.lowStockProducts.isEmpty
                                    ? Text(
                                  "No low stock products",
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                )
                                    : ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: provider.lowStockProducts.length,
                                  itemBuilder: (
                                      context,
                                      index,
                                      ) {
                                    var data = provider.lowStockProducts[index];
                                    return ListTile(
                                      leading: Icon(
                                        Icons.warning_amber,
                                        color: Colors.orange,
                                      ),
                                      title: Text(
                                        data['pname'].toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Stock: ${data['pquantity']}  |  Min Stock: ${data['pminstock']}",
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}