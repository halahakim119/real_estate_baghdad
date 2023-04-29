import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/post_entity.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostEntity>>> getPosts();
  Future<Either<Failure, PostEntity>> getPostById(String postId);
  Future<Either<Failure, String>> createPost(PostEntity postEntity);
  Future<Either<Failure, Unit>> updatePost(PostEntity postEntity);
  Future<Either<Failure, Unit>> deletePost(String postId);
}
