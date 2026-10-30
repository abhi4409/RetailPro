import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Viewmodels/staffapproval_viewmodel.dart';

class StaffApproval extends StatefulWidget {
  StaffApproval({
    super.key,
  });

  @override
  State<StaffApproval> createState() => _StaffApprovalState();
}

class _StaffApprovalState extends State<StaffApproval> {
  @override
  Widget build(
      BuildContext context,
      ) {
    var provider = Provider.of<StaffApprovalViewmodel>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Staff Approval",
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: provider.staffStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error : ${snapshot.error}",
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No staff found",
              ),
            );
          }

          var docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final snap = docs[index];
              var data = snap.data();

              String name = data['name']?.toString() ?? "";
              String email = data['email']?.toString() ?? "";
              String phone = data['phone']?.toString() ?? "";
              String role = data['role']?.toString() ?? "staff";
              String status = data['status']?.toString().trim().toLowerCase() ??
                  "pending";

              return Card(
                color: Colors.blue.shade50,
                margin: EdgeInsets.all(
                  10,
                ),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(
                    15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        email,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Phone : $phone",
                      ),
                      Text(
                        "Role : $role",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Status : ${status.toUpperCase()}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: status == "approved"
                              ? Colors.green
                              : status == "rejected"
                              ? Colors.red
                              : Colors.orange,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (status == "pending")
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await provider.updateStatus(
                                    context,
                                    snap.id,
                                    "approved",
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                ),
                                child: Text(
                                  "Approve",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await provider.updateStatus(
                                    context,
                                    snap.id,
                                    "rejected",
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                child: Text(
                                  "Reject",
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (status == "approved")
                        Text(
                          "✓ Staff Approved",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (status == "rejected")
                        Text(
                          "✕ Staff Rejected",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}