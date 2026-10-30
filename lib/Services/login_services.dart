import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference<Map<String, dynamic>> admin =
  FirebaseFirestore.instance.collection('admindata');

  Future<bool> adminLogin(
      String email,
      String password,
      ) async {
    UserCredential data = await auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    User? user = data.user;
    if (user == null) return false;

    if (user.email == "admin@gmail.com") {
      var check = await admin.doc(user.uid).get();

      if (!check.exists) {
        await admin.doc(user.uid).set({
          'uid': user.uid,
          'name': 'Admin',
          'phone': '',
          'email': user.email,
          'role': 'Admin',
        });
      }

      return true;
    } else {
      await auth.signOut();
      return false;
    }
  }
}