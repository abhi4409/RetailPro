import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import '../services/editpro_services.dart';

class EditproRepository {
  final EditproServices _services = EditproServices();

  Future<XFile?> pickImage() async => await _services.pickImage();

  Future<Uint8List> getImageBytes(
      XFile image,
      ) async => await _services.getImageBytes(
    image,
  );

  String getImageExtension(
      XFile image,
      ) => _services.getImageExtension(
    image,
  );

  Future<String> uploadImage(
      Uint8List image,
      String imageExtension,
      ) async => await _services.uploadImage(
    image,
    imageExtension,
  );

  Future<void> updateProduct(
      String docid,
      Map<String, dynamic> data,
      ) async => await _services.updateProduct(
    docid,
    data,
  );
}