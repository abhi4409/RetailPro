import 'package:firebase_auth/firebase_auth.dart';

class ChangePasswordServices {
  Future<bool> changePassword(
      String currentPassword,
      String newPassword,
      ) async {
    final user =
        FirebaseAuth.instance.currentUser;

    if (user == null) {
      return false;
    }

    final credential =
    EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    await user.reauthenticateWithCredential(
      credential,
    );

    await user.updatePassword(
      newPassword,
    );

    return true;
  }
}