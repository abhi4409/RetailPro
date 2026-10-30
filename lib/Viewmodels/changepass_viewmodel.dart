import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/Changepass_model.dart';
import '../repository/Changepass_repository.dart';

class ChangePasswordViewmodel extends ChangeNotifier {
  final ChangePasswordRepository _repository = ChangePasswordRepository();

  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController reenterPassword = TextEditingController();

  Future changePassword(
      BuildContext context,
      ) async {
    ChangePasswordModels data = ChangePasswordModels(
      currentPassword: currentPassword.text,
      newPassword: newPassword.text,
      reenterPassword: reenterPassword.text,
    );

    if (data.newPassword != data.reenterPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            "New passwords do not match",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (data.newPassword.length < 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            "Password must contain at least 6 characters",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      bool result = await _repository.changePassword(
        data,
      );

      if (!result) return;
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            "Password changed successfully",
          ),
          backgroundColor: Colors.green,
        ),
      );

      currentPassword.clear();
      newPassword.clear();
      reenterPassword.clear();
      Navigator.pop(
        context,
      );
    } on FirebaseAuthException catch (e) {
      String message = "Unable to change password";
      if (e.code == "wrong-password" || e.code == "invalid-credential") {
        message = "Current password is incorrect";
      } else if (e.code == "weak-password") {
        message = "New password is too weak";
      }

      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            message,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    currentPassword.dispose();
    newPassword.dispose();
    reenterPassword.dispose();
    super.dispose();
  }
}