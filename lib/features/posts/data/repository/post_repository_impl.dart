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
  Future<Either<Failure, String>> createPost(PostEntity postEntity) async {
    try {
      PostModel postModel = PostModel(
        title: postEntity.title,
        coordinates: postEntity.coordinates,
        likeby: postEntity.likeby,
        createdAt: postEntity.createdAt,
        photosURL: postEntity.photosURL,
        images: postEntity.images,
        province: postEntity.province,
        description: postEntity.description,
        furnishingStatus: postEntity.furnishingStatus,
        type: postEntity.type,
        category: postEntity.category,
        bathroomNumber: postEntity.bathroomNumber,
        bedroomNumber: postEntity.bedroomNumber,
        size: postEntity.size,
        price: postEntity.price,
        garden: postEntity.garden,
        garage: postEntity.garage,
        electricity24h: postEntity.electricity24h,
        water24h: postEntity.water24h,
        installedAC: postEntity.installedAC,
      );
      final response = await postDataSource.createPost(postModel);
      return response.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } on ServerException {
      return Left(ServerFailure(''));
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
