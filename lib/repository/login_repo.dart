import '../services/login_services.dart';

class LoginRepository {
  final LoginServices _services = LoginServices();

  Future<bool> adminLogin(
      String email,
      String password,
      ) async {
    return await _services.adminLogin(
      email,
      password,
    );
  }
}