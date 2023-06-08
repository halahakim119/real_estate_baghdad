import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/post_entity.dart';
import '../../../domain/usecases/create_post_use_case.dart';
import '../../../domain/usecases/delete_post_use_case.dart';
import '../../../domain/usecases/get_post_by_id_use_case.dart';
import '../../../domain/usecases/get_posts_use_case.dart';
import '../../../domain/usecases/update_post_use_case.dart';

part 'add_edit_delete_post_cubit.freezed.dart';
part 'add_edit_delete_post_state.dart';

class AddEditDeletePostCubit extends Cubit<AddEditDeletePostState> {
  final GetPostsUseCase getPostsUseCase;
  final GetPostByIdUseCase getPostByIdUseCase;
  final CreatePostUseCase createPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  AddEditDeletePostCubit({
    required this.getPostsUseCase,
    required this.getPostByIdUseCase,
    required this.createPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  }) : super(const AddEditDeletePostState.initial());

  Future<void> getPosts() async {
    emit(const AddEditDeletePostState.loading());

    final result = await getPostsUseCase.call();

    result.fold(
      (failure) => emit(AddEditDeletePostState.error(failure: failure)),
      (posts) => emit(AddEditDeletePostState.loaded(posts: posts)),
    );
  }

  Future<void> getPostById(String postId) async {
    emit(const AddEditDeletePostState.loading());

    final result = await getPostByIdUseCase.call(postId);

    result.fold(
      (failure) => emit(AddEditDeletePostState.error(failure: failure)),
      (post) => emit(AddEditDeletePostState.loaded(posts: [post])),
    );
  }

  Future<void> createPost(PostEntity postEntity) async {
    emit(const AddEditDeletePostState.loading());

    final result = await createPostUseCase.call(postEntity);

    result.fold(
      (failure) => emit(AddEditDeletePostState.error(failure: failure)),
      (_) => emit(const AddEditDeletePostState.created(message: 'Post created successfully')),
    );
  }

  Future<void> updatePost(PostEntity postEntity) async {
    emit(const AddEditDeletePostState.loading());

    final result = await updatePostUseCase.call(postEntity);

    result.fold(
      (failure) => emit(AddEditDeletePostState.error(failure: failure)),
      (_) => emit(const AddEditDeletePostState.updated(message: 'Post updated successfully')),
    );
  }

  Future<void> deletePost(String postId, String userToken) async {
    emit(const AddEditDeletePostState.loading());

    final result = await deletePostUseCase.call(postId, userToken);

    result.fold(
      (failure) => emit(AddEditDeletePostState.error(failure: failure)),
      (_) => emit(const AddEditDeletePostState.deleted(message: 'Post deleted successfully')),
    );
  }
}
