import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class ProfileServices {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference<Map<String, dynamic>> admin =
  FirebaseFirestore.instance.collection('admindata');

  Future<Map<String, dynamic>?> getProfile() async {
    User? user = auth.currentUser;
    if (user == null) return null;

    var snap = await admin.doc(user.uid).get();
    Map<String, dynamic> data = {};

    if (snap.exists) {
      data = snap.data() ?? {};
    }

    data['authEmail'] = user.email ?? "";
    return data;
  }

  Future<XFile?> pickImage() async {
    return await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      imageQuality: 85,
    );
  }

  Future<Uint8List> getImageBytes(XFile image) async {
    return await image.readAsBytes();
  }

  String getImageExtension(XFile image) {
    if (image.name.contains('.')) {
      return image.name.split('.').last.toLowerCase();
    }
    return "jpg";
  }

  Future<String?> uploadProfileImage(
      Uint8List bytes,
      String extension,
      ) async {
    User? user = auth.currentUser;
    if (user == null) return null;

    String fileName =
        "${user.uid}_${DateTime.now().millisecondsSinceEpoch}.$extension";
    String path = "profiles/$fileName";

    final supabase = Supabase.instance.client;

    await supabase.storage.from('Produtimages').uploadBinary(
      path,
      bytes,
      fileOptions: FileOptions(
        upsert: false,
      ),
    );

    return supabase.storage.from('Produtimages').getPublicUrl(path);
  }

  Future<void> saveProfileImage(String imageUrl) async {
    User? user = auth.currentUser;
    if (user == null) return;

    await admin.doc(user.uid).set(
      {
        'profileImage': imageUrl,
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  Future<void> updateProfile(
      String name,
      String phone,
      ) async {
    User? user = auth.currentUser;
    if (user == null) return;

    await admin.doc(user.uid).update({
      'name': name,
      'phone': phone,
    });
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}