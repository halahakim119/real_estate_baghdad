import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/entities/post_entity.dart';
import '../../../domain/usecases/create_post_use_case.dart';
import '../../../domain/usecases/delete_post_use_case.dart';
import '../../../domain/usecases/get_post_by_id_use_case.dart';
import '../../../domain/usecases/get_posts_use_case.dart';
import '../../../domain/usecases/update_post_use_case.dart';

part 'add_edit_delete_post_event.dart';
part 'add_edit_delete_post_state.dart';

class AddEditDeletePostBloc
    extends Bloc<AddEditDeletePostEvent, AddEditDeletePostState> {
  final GetPostsUseCase getPostsUseCase;
  final GetPostByIdUseCase getPostByIdUseCase;
  final CreatePostUseCase createPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  AddEditDeletePostBloc({
    required this.getPostsUseCase,
    required this.getPostByIdUseCase,
    required this.createPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  }) : super(AddEditDeletePostInitial()) {
    on<GetPostsEvent>((event, emit) async {
      emit(AddEditDeletePostLoading());

      final result = await getPostsUseCase.call();

      result.fold(
        (failure) => emit(AddEditDeletePostError(failure: failure)),
        (posts) => emit(AddEditDeletePostLoaded(posts: posts)),
      );
    });

    on<GetPostByIdEvent>((event, emit) async {
      emit(AddEditDeletePostLoading());

      final result = await getPostByIdUseCase.call(event.postId);

      result.fold(
        (failure) => emit(AddEditDeletePostError(failure: failure)),
        (post) => emit(AddEditDeletePostLoaded(posts: [post])),
      );
    });

    on<CreatePostEvent>((event, emit) async {
      emit(AddEditDeletePostLoading());

      final result = await createPostUseCase.call(event.postEntity);

      result.fold(
        (failure) => emit(AddEditDeletePostError(failure: failure)),
        (_) => emit(AddEditDeletePostCreated(message: 'Post created successfully')),
      );
    });

    on<UpdatePostEvent>((event, emit) async {
      emit(AddEditDeletePostLoading());

      final result = await updatePostUseCase.call(event.postEntity);

      result.fold(
        (failure) => emit(AddEditDeletePostError(failure: failure)),
        (_) => emit(AddEditDeletePostUpdated(message: 'Post updated successfully')),
      );
    });

    on<DeletePostEvent>((event, emit) async {
      emit(AddEditDeletePostLoading());

      final result = await deletePostUseCase.call(event.postId, event.userToken);

      result.fold(
        (failure) => emit(AddEditDeletePostError(failure: failure)),
        (_) => emit(AddEditDeletePostDeleted(message: 'Post deleted successfully')),
      );
    });
  }
}
