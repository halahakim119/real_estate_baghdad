part of 'image_bloc.dart';

abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final File image;

  ImageLoaded(this.image);
}


class ImageError extends ImageState {
  final String errorMessage;

  ImageError(this.errorMessage);
}
