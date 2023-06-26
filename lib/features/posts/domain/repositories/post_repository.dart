import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/post_entity.dart';

abstract class PostRepository {
  Future<Either<Failure, PostEntity>> getPostById(String postId);
  Future<Either<Failure, String>> createPost(PostEntity postEntity);
  Future<Either<Failure, String>> updatePost(PostEntity postEntity);
  Future<Either<Failure, String>> deletePost(String postId, String userToken);
}
