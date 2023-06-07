part of 'add_edit_delete_post_bloc.dart';

abstract class AddEditDeletePostEvent extends Equatable {
  const AddEditDeletePostEvent();

  @override
  List<Object?> get props => [];
}

class GetPostsEvent extends AddEditDeletePostEvent {}

class GetPostByIdEvent extends AddEditDeletePostEvent {
  final String postId;

  const GetPostByIdEvent(this.postId);

  @override
  List<Object?> get props => [postId];
}

class CreatePostEvent extends AddEditDeletePostEvent {
  final PostEntity postEntity;

  const CreatePostEvent(this.postEntity);

  @override
  List<Object?> get props => [postEntity];
}

class UpdatePostEvent extends AddEditDeletePostEvent {
  final PostEntity postEntity;

  const UpdatePostEvent(this.postEntity);

  @override
  List<Object?> get props => [postEntity];
}

class DeletePostEvent extends AddEditDeletePostEvent {
  final String postId;
  final String userToken;

  const DeletePostEvent(this.postId, this.userToken);

  @override
  List<Object?> get props => [postId, userToken];
}
