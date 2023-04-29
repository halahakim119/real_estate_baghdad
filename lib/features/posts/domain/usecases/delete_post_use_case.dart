import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/post_repository.dart';

class DeletePostUseCase {
  final PostRepository repository;
  DeletePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String postId) async {
    return await repository.deletePost(postId);
  }
}
