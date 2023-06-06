import 'dart:io';

import '../repositories/image_repository.dart';

class UploadImageUseCase {
  final ImageRepository _imageRepository;

  UploadImageUseCase(this._imageRepository);

  Future<bool> execute(File image) async {
    return await _imageRepository.uploadImage(image);
  }
}