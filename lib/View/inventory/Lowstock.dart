import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Viewmodels/lowstock_viewmodel.dart';

class Lowsto extends StatefulWidget {
  const Lowsto({
    super.key,
  });

  @override
  State<Lowsto> createState() =>
      _LowstoState();
}

class _LowstoState extends State<Lowsto> {
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
        title: const Text(
          "Low Stock items",
        ),
      ),
      body: provider.loading
          ? const Center(
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
          ? const Center(
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
        const EdgeInsets
            .all(
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
          provider
              .formatQuantity(
            product[
            'pquantity'],
            unit,
          );

          return Card(
            elevation: 5,
            margin:
            const EdgeInsets
                .only(
              bottom: 12,
            ),
            child: Container(
              width:
              double.infinity,
              padding:
              const EdgeInsets
                  .all(
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
                  const Icon(
                    Icons
                        .inventory_2,
                    size: 35,
                    color:
                    Colors.red,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text(
                          product['pname']
                              ?.toString() ??
                              "",
                          maxLines: 2,
                          overflow:
                          TextOverflow
                              .ellipsis,
                          style:
                          const TextStyle(
                            fontSize: 16,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          product['pcatogory']
                              ?.toString() ??
                              "",
                          style:
                          const TextStyle(
                            color: Colors
                                .grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 10,
                      vertical: 8,
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
                      const TextStyle(
                        fontSize: 13,
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