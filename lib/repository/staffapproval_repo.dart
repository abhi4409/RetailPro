import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/staffapproval_services.dart';

class StaffApprovalRepository {
  final StaffApprovalServices _services =
  StaffApprovalServices();

  Stream<QuerySnapshot<Map<String, dynamic>>> getStaff() {
    return _services.getStaff();
  }

  Future<void> updateStatus(
      String id,
      String status,
      ) async {
    await _services.updateStatus(
      id,
      status,
    );
  }
}