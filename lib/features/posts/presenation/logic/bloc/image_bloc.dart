import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';

import '../../../domain/entities/image_entity.dart';
import '../../../domain/usecases/pick_image_usecase.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final PickImageUseCase _pickImageUseCase;

  ImageBloc(this._pickImageUseCase) : super(ImageInitial()) {
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
      yield ImageLoaded(ImageEntity(imageFile.path));
    } else {
      yield ImageError('Failed to pick image.');
    }
  }
}
