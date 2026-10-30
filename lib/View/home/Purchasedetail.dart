import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Viewmodels/purchasedetail_viewmodel.dart';

class PurchaseDetail extends StatefulWidget {
  final Map<String, dynamic> data;

  const PurchaseDetail({
    super.key,
    required this.data,
  });

  @override
  State<PurchaseDetail> createState() => _PurchaseDetailState();
}

class _PurchaseDetailState extends State<PurchaseDetail> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PurchaseDetailViewmodel(widget.data),
      child: Consumer<PurchaseDetailViewmodel>(
        builder: (context, provider, child) {
          final data = provider.data;
          final List items = provider.items;
          final String date = provider.date;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              title: const Text("Purchase Details"),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Supplier Information",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text("Supplier Name: ${data['suppliername'] ?? ''}"),
                        const SizedBox(height: 10),
                        Text("Mobile Number: ${data['suppliermobile'] ?? ''}"),
                        const SizedBox(height: 10),
                        Text("Bill Number: ${data['billno'] ?? ''}"),
                        const SizedBox(height: 10),
                        Text("Purchase Date: $date"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Purchased Products",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        color: Colors.green.shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${index + 1}. ${item['productname'] ?? ''}",
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Divider(),
                              Text("Category: ${item['category'] ?? ''}"),
                              const SizedBox(height: 8),
                              Text("Barcode: ${item['barcode'] ?? ''}"),
                              const SizedBox(height: 8),
                              Text("Unit: ${item['unit'] ?? ''}"),
                              const SizedBox(height: 8),
                              Text("Quantity: ${item['quantity'] ?? ''}"),
                              const SizedBox(height: 8),
                              Text("Purchase Price: ₹${item['purchaseprice'] ?? ''}"),
                              const SizedBox(height: 8),
                              Text("Selling Price: ₹${item['sellingprice'] ?? ''}"),
                              const SizedBox(height: 8),
                              Text("MRP: ₹${item['mrp'] ?? ''}"),
                              const SizedBox(height: 8),
                              Text("Minimum Stock: ${item['minstock'] ?? ''}"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.cyan.shade100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Purchase Summary",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text("Total Products: ${items.length}"),
                        const SizedBox(height: 10),
                        Text(
                          "Total Amount: ₹${data['total'] ?? 0}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Notes",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("${data['notes'] ?? 'No notes'}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}