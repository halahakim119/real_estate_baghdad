import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:real_estate_baghdad/features/posts/domain/usecases/upload_image_use_case.dart';

import '../../../domain/entities/image_entity.dart';
import '../../../domain/usecases/pick_image_usecase.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final PickImageUseCase _pickImageUseCase;
  final UploadImageUseCase _uploadImageUseCase;

  ImageBloc(this._pickImageUseCase,this._uploadImageUseCase) : super(ImageInitial()) {
    on<PickImageEvent>((event, emit) {
      add(PickImageEvent());
    });
  }

  @override
  Stream<ImageState> _mapPickImageEventToState() async* {
  yield ImageLoading();

  final File? imageFile = await _pickImageUseCase.execute();

  if (imageFile != null) {
    final bool isUploaded = await _uploadImageUseCase.execute(imageFile);
    if (isUploaded) {
      yield ImageLoaded(imageFile);
    } else {
      yield ImageError('Failed to upload image.');
    }
  } else {
    yield ImageError('Failed to pick image.');
  }
}

}
