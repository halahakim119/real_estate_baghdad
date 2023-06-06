import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../domain/repositories/image_repository.dart';
import '../datasource/image_data_source.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImagePicker _imagePicker = ImagePicker();
  final ImageDataSource _imageDataSource = ImageDataSource();

  @override
  Future<File?> pickImage() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  @override
  Future<bool> uploadImage(File image) async {
    return await _imageDataSource.uploadImage(image);
  }
}
