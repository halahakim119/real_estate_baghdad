import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/post_entity.dart';
import '../../../domain/usecases/create_post_use_case.dart';
import '../../../domain/usecases/delete_post_use_case.dart';
import '../../../domain/usecases/get_post_by_id_use_case.dart';
import '../../../domain/usecases/update_post_use_case.dart';

part 'add_edit_delete_post_cubit.freezed.dart';
part 'add_edit_delete_post_state.dart';

class AddEditDeletePostCubit extends Cubit<AddEditDeletePostState> {
  final GetPostByIdUseCase getPostByIdUseCase;
  final CreatePostUseCase createPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  AddEditDeletePostCubit({
    required this.getPostByIdUseCase,
    required this.createPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  }) : super(const AddEditDeletePostState.initial());

  Future<void> getPostById(String postId) async {
    emit(const AddEditDeletePostState.loading());

    final result = await getPostByIdUseCase.call(postId);

    return result.fold(
      (failure) => emit(AddEditDeletePostState.error(message: failure.message)),
      (post) => emit(AddEditDeletePostState.loaded(posts: [post])),
    );
  }

  Future<void> createPost(PostEntity postEntity) async {
    emit(const AddEditDeletePostState.loading());

    final result = await createPostUseCase.call(postEntity);

    return result.fold(
      (failure) => emit(AddEditDeletePostState.error(message: failure.message)),
      (message) => emit(AddEditDeletePostState.created(message: message)),
    );
  }

  Future<void> updatePost(PostEntity postEntity) async {
    emit(const AddEditDeletePostState.loading());

    final result = await updatePostUseCase.call(postEntity);

    return result.fold(
      (failure) => emit(AddEditDeletePostState.error(message: failure.message)),
      (message) => emit(AddEditDeletePostState.updated(message: message)),
    );
  }

  Future<void> deletePost(String postId, String userToken) async {
    emit(const AddEditDeletePostState.loading());

    final result = await deletePostUseCase.call(postId, userToken);

    return result.fold(
      (failure) => emit(AddEditDeletePostState.error(message: failure.message)),
      (message) => emit(AddEditDeletePostState.deleted(message: message)),
    );
  }
}
