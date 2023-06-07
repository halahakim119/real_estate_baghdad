import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasource/post_data_source.dart';
import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final PostDataSource postDataSource;

  PostRepositoryImpl({required this.postDataSource});

  @override
  Future<Either<Failure, Unit>> createPost(PostEntity postEntity) async {
    try {
      PostModel postModel = PostModel(
        title: postEntity.title,
        cords: postEntity.cords,
        likesNum: postEntity.likesNum,
        dateAdded: postEntity.dateAdded,
        link: postEntity.link,
        images: postEntity.images,
        province: postEntity.province,
        overview: postEntity.overview,
        furnishingStatus: postEntity.furnishingStatus,
        postType: postEntity.postType,
        categoryType: postEntity.categoryType,
        bathroomNum: postEntity.bathroomNum,
        bedroomNum: postEntity.bedroomNum,
        size: postEntity.size,
        price: postEntity.price,
        garden: postEntity.garden,
        garage: postEntity.garage,
        electricity24H: postEntity.electricity24H,
        water24H: postEntity.water24H,
        installedAC: postEntity.installedAC,
      );
      final response = await postDataSource.createPost(postModel);
      return response.fold(
        (failure) => Left(failure),
        (_) => const Right(unit),
      );
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(String postId, String userToken) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PostEntity>> getPostById(String postId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntity postEntity) {
    throw UnimplementedError();
  }
}
