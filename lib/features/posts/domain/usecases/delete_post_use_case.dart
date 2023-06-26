import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/post_repository.dart';

class DeletePostUseCase {
  final PostRepository repository;
  DeletePostUseCase(this.repository);

  Future<Either<Failure, String>> call(String postId, String userToken) async {
    return await repository.deletePost(postId, userToken);
  }
}
