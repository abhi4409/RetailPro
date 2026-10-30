import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../models/profile_models.dart';
import '../repository/profile_repo.dart';

class ProfileViewmodel extends ChangeNotifier {
  final ProfileModels _profileModels = ProfileModels();
  final ProfileRepository _repository = ProfileRepository();

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController role = TextEditingController();

  ProfileViewmodel() {
    getProfile();
  }

  bool get edit => _profileModels.edit;
  bool get loading => _profileModels.loading;
  bool get imageUploading => _profileModels.imageUploading;
  Uint8List? get profileImage => _profileModels.profileImage;
  String get profileImageUrl => _profileModels.profileImageUrl;

  Future getProfile() async {
    _profileModels.loading = true;
    notifyListeners();

    try {
      Map<String, dynamic>? data = await _repository.getProfile();

      if (data == null) {
        _profileModels.loading = false;
        notifyListeners();
        return;
      }

      name.text = data['name']?.toString() ?? "";
      phone.text = data['phone']?.toString() ?? "";
      email.text = data['email']?.toString() ??
          data['authEmail']?.toString() ??
          "";
      role.text = data['role']?.toString() ?? "Admin";
      _profileModels.profileImageUrl =
          data['profileImage']?.toString() ?? "";
    } catch (e) {
      debugPrint("Profile loading error $e");
    }

    _profileModels.loading = false;
    notifyListeners();
  }

  void enableEdit() {
    _profileModels.edit = true;
    notifyListeners();
  }

  Future pickProfileImage(BuildContext context) async {
    var picked = await _repository.pickImage();
    if (picked == null) return;

    try {
      _profileModels.imageUploading = true;
      notifyListeners();

      Uint8List bytes = await _repository.getImageBytes(picked);
      _profileModels.profileImage = bytes;

      String extension = _repository.getImageExtension(picked);
      String? imageUrl = await _repository.uploadProfileImage(
        bytes,
        extension,
      );

      if (imageUrl == null) return;

      _profileModels.profileImageUrl = imageUrl;
      await _repository.saveProfileImage(imageUrl);
      notifyListeners();

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Profile picture updated successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Image upload failed $e"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      _profileModels.imageUploading = false;
      notifyListeners();
    }
  }

  Future updateProfile(BuildContext context) async {
    try {
      await _repository.updateProfile(
        name.text,
        phone.text,
      );

      _profileModels.edit = false;
      notifyListeners();

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Profile updated successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Profile update failed $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future logout() async {
    await _repository.logout();
  }

  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    role.dispose();
    super.dispose();
  }
}