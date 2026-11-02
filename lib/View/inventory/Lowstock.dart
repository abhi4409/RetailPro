import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Viewmodels/lowstock_viewmodel.dart';

class Lowsto extends StatefulWidget {
  Lowsto({
    super.key,
  });

  @override
  State<Lowsto> createState() => _LowstoState();
}

class _LowstoState extends State<Lowsto> {
  String formatQuantity(
      dynamic quantity,
      dynamic unit,
      ) {
    double qty = double.tryParse(
      quantity.toString(),
    ) ??
        0.0;

    String unitText =
    unit.toString().toLowerCase().trim();

    if (unitText == "kg") {
      return qty
          .toStringAsFixed(2)
          .replaceAll(
        RegExp(r'0+$'),
        '',
      )
          .replaceAll(
        RegExp(r'\.$'),
        '',
      );
    }

    return qty.toInt().toString();
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    var provider =
    Provider.of<LowstockViewmodel>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          "Low Stock items",
        ),
      ),
      body: provider.loading
          ? Center(
        child:
        CircularProgressIndicator(),
      )
          : provider.error.isNotEmpty
          ? Center(
        child: Text(
          "Error : ${provider.error}",
        ),
      )
          : provider
          .lowStockProducts
          .isEmpty
          ? Center(
        child: Text(
          "No low stock items",
          style: TextStyle(
            fontSize: 18,
            fontWeight:
            FontWeight.bold,
          ),
        ),
      )
          : ListView.builder(
        padding:
        EdgeInsets.all(
          20,
        ),
        itemCount: provider
            .lowStockProducts
            .length,
        itemBuilder: (
            context,
            index,
            ) {
          var product =
          provider
              .lowStockProducts[
          index];

          String unit =
              product['punits']
                  ?.toString() ??
                  "";

          String quantity =
          formatQuantity(
            product[
            'pquantity'],
            unit,
          );

          return Card(
            elevation: 5,
            margin:
            EdgeInsets.only(
              bottom: 12,
            ),
            child: Container(
              width: double
                  .infinity,
              padding:
              EdgeInsets.all(
                15,
              ),
              decoration:
              BoxDecoration(
                borderRadius:
                BorderRadius
                    .circular(
                  20,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons
                        .inventory_2,
                    size: 35,
                    color:
                    Colors.red,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text(
                          product[
                          'pname']
                              .toString(),
                          maxLines:
                          2,
                          overflow:
                          TextOverflow
                              .ellipsis,
                          style:
                          TextStyle(
                            fontSize:
                            16,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                        SizedBox(
                          height:
                          5,
                        ),
                        Text(
                          product[
                          'pcatogory']
                              .toString(),
                          style:
                          TextStyle(
                            color:
                            Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding:
                    EdgeInsets
                        .symmetric(
                      horizontal:
                      10,
                      vertical:
                      8,
                    ),
                    decoration:
                    BoxDecoration(
                      borderRadius:
                      BorderRadius
                          .circular(
                        15,
                      ),
                      color: Colors
                          .red
                          .shade100,
                    ),
                    child: Text(
                      "Only $quantity $unit Left",
                      style:
                      TextStyle(
                        fontSize:
                        13,
                        color:
                        Colors.red,
                        fontWeight:
                        FontWeight
                            .bold,
                      ),
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