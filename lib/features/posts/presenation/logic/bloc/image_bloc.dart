
import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';

import '../../../domain/usecases/pick_image_usecase.dart';
import '../../../domain/usecases/upload_image_use_case.dart';

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
  Stream<ImageState> mapEventToState(ImageEvent event) async* {
    if (event is PickImageEvent) {
      yield* _mapPickImageEventToState();
    }
  }

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
