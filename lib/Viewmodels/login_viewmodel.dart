import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/login_models.dart';
import '../View/home/Bottonnavi.dart';
import '../repository/login_repo.dart';


class LoginViewmodel extends ChangeNotifier {
  final LoginModels _loginModels = LoginModels();
  final LoginRepository _repository = LoginRepository();

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  bool get showPassword => _loginModels.showPassword;
  bool get loading => _loginModels.loading;

  void passwordShow() {
    _loginModels.showPassword = !_loginModels.showPassword;
    notifyListeners();
  }

  Future adminLogin(BuildContext context) async {
    try {
      _loginModels.loading = true;
      notifyListeners();

      bool result = await _repository.adminLogin(
        email.text,
        pass.text,
      );

      if (!context.mounted) return;

      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login successfully"),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Bottomna(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("This is not an admin account"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? "Invalid email or password"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      _loginModels.loading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }
}