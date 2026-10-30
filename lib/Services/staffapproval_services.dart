import 'package:cloud_firestore/cloud_firestore.dart';

class StaffApprovalServices {
  final CollectionReference<Map<String, dynamic>> staff =
  FirebaseFirestore.instance.collection(
    'staffdata',
  );

  Stream<QuerySnapshot<Map<String, dynamic>>> getStaff() {
    return staff.snapshots();
  }

  Future<void> updateStatus(
      String id,
      String status,
      ) async {
    await staff.doc(id).update({
      'status': status,
    });
  }
}