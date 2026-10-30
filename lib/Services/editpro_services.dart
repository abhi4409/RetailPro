import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditproServices {
  final CollectionReference<Map<String, dynamic>> products = FirebaseFirestore.instance.collection(
    'productsdata',
  );

  Future<XFile?> pickImage() async => await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );

  Future<Uint8List> getImageBytes(
      XFile image,
      ) async => await image.readAsBytes();

  String getImageExtension(
      XFile image,
      ) => image.name.contains(
    '.',
  ) ? image.name.split(
    '.',
  ).last.toLowerCase() : "jpg";

  Future<String> uploadImage(
      Uint8List image,
      String imageExtension,
      ) async {
    String path = "products/${DateTime.now().millisecondsSinceEpoch}.$imageExtension";
    await Supabase.instance.client.storage.from(
      'Produtimages',
    ).uploadBinary(
      path,
      image,
    );
    return Supabase.instance.client.storage.from(
      'Produtimages',
    ).getPublicUrl(
      path,
    );
  }

  Future<void> updateProduct(
      String docid,
      Map<String, dynamic> data,
      ) async => await products.doc(
    docid,
  ).update(
    data,
  );
}