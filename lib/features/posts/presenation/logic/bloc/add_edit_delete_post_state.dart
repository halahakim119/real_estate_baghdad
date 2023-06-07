part of 'add_edit_delete_post_bloc.dart';

abstract class AddEditDeletePostState extends Equatable {
  const AddEditDeletePostState();

  @override
  List<Object?> get props => [];
}

class AddEditDeletePostInitial extends AddEditDeletePostState {}

class AddEditDeletePostLoading extends AddEditDeletePostState {}

class AddEditDeletePostLoaded extends AddEditDeletePostState {
  final List<PostEntity> posts;

  const AddEditDeletePostLoaded({required this.posts});

  @override
  List<Object?> get props => [posts];
}

class AddEditDeletePostCreated extends AddEditDeletePostState {
  final String message;

  const AddEditDeletePostCreated({required this.message});

  @override
  List<Object?> get props => [message];
}

class AddEditDeletePostUpdated extends AddEditDeletePostState {
  final String message;

  const AddEditDeletePostUpdated({required this.message});

  @override
  List<Object?> get props => [message];
}

class AddEditDeletePostDeleted extends AddEditDeletePostState {
  final String message;

  const AddEditDeletePostDeleted({required this.message});

  @override
  List<Object?> get props => [message];
}

class AddEditDeletePostError extends AddEditDeletePostState {
  final Failure failure;

  const AddEditDeletePostError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
