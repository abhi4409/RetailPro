import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import '../services/addpro_services.dart';

class AddproRepository {
  final AddproServices _services = AddproServices();

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
      Uint8List productImage,
      String imageExtension,
      ) async => await _services.uploadImage(
    productImage,
    imageExtension,
  );

  Future addProduct(
      Map<String, dynamic> data,
      ) async => await _services.addProduct(
    data,
  );
}