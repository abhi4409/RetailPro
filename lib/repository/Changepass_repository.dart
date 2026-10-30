import '../Services/Changepass_Services.dart';
import '../models/Changepass_model.dart';
class ChangePasswordRepository {
  final ChangePasswordServices _services = ChangePasswordServices();

  Future<bool> changePassword(
      ChangePasswordModels data,
      ) async {
    return await _services.changePassword(
      data.currentPassword,
      data.newPassword,
    );
  }
}