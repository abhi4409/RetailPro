import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../repository/staffapproval_repo.dart';

class StaffApprovalViewmodel extends ChangeNotifier {
  final StaffApprovalRepository _repository = StaffApprovalRepository();

  Stream<QuerySnapshot<Map<String, dynamic>>> get staffStream {
    return _repository.getStaff();
  }

  Future<void> updateStatus(
      BuildContext context,
      String id,
      String status,
      ) async {
    try {
      await _repository.updateStatus(
        id,
        status,
      );

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            status == "approved"
                ? "Staff approved successfully"
                : "Staff rejected",
          ),
          backgroundColor:
          status == "approved" ? Colors.green : Colors.red,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error: $e",
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}