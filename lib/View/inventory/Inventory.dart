import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Viewmodels/inventory_viewmodel.dart';
import 'Addproducts.dart';
import 'Instock.dart';
import 'Lowstock.dart';

class Inven extends StatefulWidget {
  Inven({
    super.key,
  });

  @override
  State<Inven> createState() => _InvenState();
}

class _InvenState extends State<Inven> {
  @override
  Widget build(
      BuildContext context,
      ) {
    var provider = Provider.of<InventoryViewmodel>(
      context,
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Addp(),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: provider.loading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "lib/images/inven.png",
                  ),
                  fit: BoxFit.fill,
                ),
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextField(
                onChanged: (value) => provider.searchProduct(
                  value,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                  hintText: "search product name ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.green.shade100,
                            child: Icon(
                              Icons.inventory_2,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            "Total products ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            provider.docs.length.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Insto(),
                          ),
                        );
                      },
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.blue.shade100,
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              "Instock",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${provider.inStock}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Lowsto(),
                          ),
                        );
                      },
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.orange.shade100,
                              child: Icon(
                                Icons.warning_amber_sharp,
                                color: Colors.orange,
                              ),
                            ),
                            Text(
                              "Low stock",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${provider.lowStock}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
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
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: provider.filteredDocs.length,
              itemBuilder: (context, index) {
                final snap = provider.filteredDocs[index];

                return Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 10,
                  ),
                  child: Card(
                    color: Colors.cyan.shade50,
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 30,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 55,
                                  child: Center(
                                    child: Text(
                                      snap['pname'].toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  height: 25,
                                  child: Center(
                                    child: Text(
                                      snap['pcatogory'].toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 35,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "QTY: ",
                                      ),
                                      Flexible(
                                        child: Text(
                                          snap['pquantity'].toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 35,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          snap['pselling price'].toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        "/",
                                      ),
                                      Flexible(
                                        child: Text(
                                          snap['punits'].toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        "edit",
                                        arguments: {
                                          "PNAME": snap["pname"],
                                          "PCATEGORY": snap["pcatogory"],
                                          "PUNIT": snap["punits"],
                                          "PBARCODE": snap["pbarcode"],
                                          "PPURCHASEPRICE":
                                          snap["Ppurchaseprice"],
                                          "PSELLINGPRICE":
                                          snap["pselling price"],
                                          "PQUANTITY": snap["pquantity"],
                                          "PMINSTOCK": snap["pminstock"],
                                          "PSUPPLIERNAME":
                                          snap["psuppername"],
                                          "PDATE": snap["pdate"],
                                          "PINVOICE": snap["pinvoice"],
                                          "docid": snap.id,
                                        },
                                      );
                                    },
                                    child: Text(
                                      "edit",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 100,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await provider.deleteProduct(
                                        snap.id,
                                      );
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Product deleted",
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "delete",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}