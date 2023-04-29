import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

class GetPostByIdUseCase {
  final PostRepository repository;
  GetPostByIdUseCase(this.repository);

  Future<Either<Failure, PostEntity>> call(String postId) async {
    return await repository.getPostById(postId);
  }
}
