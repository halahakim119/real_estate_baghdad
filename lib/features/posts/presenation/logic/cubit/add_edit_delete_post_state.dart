part of 'add_edit_delete_post_cubit.dart';

@immutable
@freezed
class AddEditDeletePostState with _$AddEditDeletePostState {
  const factory AddEditDeletePostState.initial() = _Initial;
  const factory AddEditDeletePostState.loading() = _Loading;
  const factory AddEditDeletePostState.loaded({required List<PostEntity> posts}) = _Loaded;
  const factory AddEditDeletePostState.created({required String message}) = _Created;
  const factory AddEditDeletePostState.updated({required String message}) = _Updated;
  const factory AddEditDeletePostState.deleted({required String message}) = _Deleted;
  const factory AddEditDeletePostState.error({required Failure failure}) = _Error;
}