import 'dart:io';

abstract class ImageRepository {
  Future<File?> pickImage();
  Future<bool> uploadImage(File image);
}
