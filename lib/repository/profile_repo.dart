import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import '../services/profile_services.dart';

class ProfileRepository {
  final ProfileServices _services = ProfileServices();

  Future<Map<String, dynamic>?> getProfile() async =>
      await _services.getProfile();

  Future<XFile?> pickImage() async => await _services.pickImage();

  Future<Uint8List> getImageBytes(XFile image) async =>
      await _services.getImageBytes(image);

  String getImageExtension(XFile image) => _services.getImageExtension(image);

  Future<String?> uploadProfileImage(
      Uint8List bytes,
      String extension,
      ) async =>
      await _services.uploadProfileImage(bytes, extension);

  Future<void> saveProfileImage(String imageUrl) async =>
      await _services.saveProfileImage(imageUrl);

  Future<void> updateProfile(
      String name,
      String phone,
      ) async =>
      await _services.updateProfile(name, phone);

  Future<void> logout() async => await _services.logout();
}