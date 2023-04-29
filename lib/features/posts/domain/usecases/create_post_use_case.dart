import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

class CreatePostUseCase {
  final PostRepository repository;
  CreatePostUseCase(this.repository);
  // add a new post and returns back an id of the post or failure
  Future<Either<Failure, String>> call(PostEntity postEntity) async {
    return await repository.createPost(postEntity);
  }
}
