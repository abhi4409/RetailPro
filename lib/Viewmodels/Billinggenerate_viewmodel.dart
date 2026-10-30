import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/Billinggenrate_model.dart';
import '../repository/Billinggenrate_repository.dart';
class BillinggenerateViewmodel extends ChangeNotifier {
  late BillinggenerateModels _billinggenerateModels;
  final BillinggenerateRepository _repository = BillinggenerateRepository();
  BillinggenerateViewmodel({
    required String customerName,
    required String billNo,
    required String customerMobile,
    required List<Map<String, dynamic>> cart,
    required double totalAmount,
    required String paymentMethod,
  }) {
    _billinggenerateModels = BillinggenerateModels(
      customerName: customerName,
      billNo: billNo,
      customerMobile: customerMobile,
      cart: List<Map<String, dynamic>>.from(cart),
      totalAmount: totalAmount,
      paymentMethod: paymentMethod,
    );
  }
  String get customerName => _billinggenerateModels.customerName;
  String get billNo => _billinggenerateModels.billNo;
  String get customerMobile => _billinggenerateModels.customerMobile;
  List<Map<String, dynamic>> get cart => _billinggenerateModels.cart;
  double get totalAmount => _billinggenerateModels.totalAmount;
  String get paymentMethod => _billinggenerateModels.paymentMethod;
  DateTime get now => _billinggenerateModels.now;
  String get customerDisplayName => _repository.getCustomerDisplayName(_billinggenerateModels.customerName);
  double getPrice(Map<String, dynamic> item) {
    return _repository.getPrice(item);
  }
  int getQty(Map<String, dynamic> item) {
    return _repository.getQty(item);
  }
  double getAmount(Map<String, dynamic> item) {
    return _repository.getAmount(item);
  }
  Future<void> printBill() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(30),
        build: (context) {
          return [
            pw.Center(
              child: pw.Text(
                "RETAIL PRO",
                style: pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.SizedBox(height: 5),
            pw.Center(
              child: pw.Text("Receipt / Tax Invoice", style: pw.TextStyle(fontSize: 14)),
            ),
            pw.SizedBox(height: 20),
            pw.Divider(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Bill No: $billNo"),
                pw.Text("Date: ${now.day}/${now.month}/${now.year}"),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text("Customer: $customerDisplayName"),
                pw.Text("Time: ${now.hour}:${now.minute}"),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Text(customerMobile.isEmpty ? "Mobile: -" : "Mobile: $customerMobile"),
            pw.SizedBox(height: 20),
            pw.Container(
              padding: pw.EdgeInsets.symmetric(vertical: 8),
              child: pw.Row(
                children: [
                  pw.SizedBox(
                    width: 30,
                    child: pw.Text("No", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text("Product", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Expanded(
                    child: pw.Text("Qty", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Expanded(
                    child: pw.Text("Rate", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                  pw.Expanded(
                    child: pw.Text("Amount", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                ],
              ),
            ),
            pw.Divider(),
            ...List.generate(cart.length, (index) {
              Map<String, dynamic> item = cart[index];
              double price = getPrice(item);
              int qty = getQty(item);
              double amount = getAmount(item);
              return pw.Column(
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.symmetric(vertical: 7),
                    child: pw.Row(
                      children: [
                        pw.SizedBox(width: 30, child: pw.Text("${index + 1}")),
                        pw.Expanded(flex: 3, child: pw.Text(item['name']?.toString() ?? "")),
                        pw.Expanded(child: pw.Text(qty.toString())),
                        pw.Expanded(child: pw.Text("Rs.${price.toStringAsFixed(2)}")),
                        pw.Expanded(child: pw.Text("Rs.${amount.toStringAsFixed(2)}")),
                      ],
                    ),
                  ),
                  pw.Divider(),
                ],
              );
            }),
            pw.SizedBox(height: 15),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text("Subtotal: "),
                pw.Text(
                  "Rs.${totalAmount.toStringAsFixed(2)}",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
            pw.SizedBox(height: 8),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [pw.Text("Discount: Rs.0.00")],
            ),
            pw.SizedBox(height: 8),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text(
                  "Total Amount: ",
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  "Rs.${totalAmount.toStringAsFixed(2)}",
                  style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Divider(),
            pw.Text(
              "Payment Method: ${paymentMethod.toUpperCase()}",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 30),
            pw.Center(
              child: pw.Text(
                "Thank you for shopping with us!",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ),
          ];
        },
      ),
    );
    await Printing.layoutPdf(
      name: billNo,
      onLayout: (PdfPageFormat format) async {
        return pdf.save();
      },
    );
  }
}