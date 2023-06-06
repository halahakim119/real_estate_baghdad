import 'dart:io';

import '../repositories/image_repository.dart';


class PickImageUseCase {
  final ImageRepository _imageRepository;

  PickImageUseCase(this._imageRepository);

  Future<File?> execute() async {
    return await _imageRepository.pickImage();
  }
}