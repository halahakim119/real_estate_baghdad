import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:http_parser/http_parser.dart';

import '../../../../core/error/failure.dart';
import '../../../users/data/models/user_model.dart';
import '../models/post_model.dart';

abstract class PostDataSource {
  Future<Either<Failure, PostModel>> getPostById(String postId);
  Future<Either<Failure, String>> createPost(PostModel postModel);
  Future<Either<Failure, Unit>> updatePost(PostModel postModel);
  Future<Either<Failure, Unit>> deletePost(String postId, String userToken);
}

UserModel? getUserData() {
  UserModel? user;
  final userBox = Hive.box<UserModel>('userBox');
  if (userBox.isNotEmpty) {
    user = userBox.getAt(0);
  }
  return user;
}

class PostDataSourceImpl implements PostDataSource {
  @override
  Future<Either<Failure, String>> createPost(PostModel postModel) async {
    try {
      final UserModel? user = getUserData();

      final dio = Dio();

      final fields = {
        'title': postModel.title,
        'size': postModel.size.toString(),
        'price': postModel.price.toString(),
        'description': postModel.description,
        'province': postModel.province,
        'id': user!.id,
        'token': user.token,
        'cords': postModel.coordinates.toString(),
        'type': postModel.type,
        'category': postModel.category,
        'furnished_status': postModel.furnishingStatus,
        'ac': postModel.installedAC.toString(),
        'electricity24': postModel.electricity24h.toString(),
        'water24': postModel.water24h.toString(),
        'garden': postModel.garden.toString(),
        'bedroom_num': postModel.bedroomNumber.toString(),
        'bathroom_num': postModel.bathroomNumber.toString(),
        'garage': postModel.garage.toString(),
      };

      // Add image files to the form data
      if (postModel.images!.isNotEmpty) {
        final formData = FormData();
        for (int i = 0; i < postModel.images!.length && i < 4; i++) {
          final bytes = await postModel.images![i].readAsBytes();
          formData.files.add(MapEntry(
            'image${i + 1}',
            MultipartFile.fromBytes(
              bytes,
              filename: 'image${i + 1}.png',
              contentType: MediaType('image', 'png'),
            ),
          ));
        }

        formData.fields.addAll(
            fields.entries.map((entry) => MapEntry(entry.key, entry.value!)));

        final response = await dio.post(
          'http://35.180.62.182/api/houses/phone/create',
          data: formData,
        );

        if (response.statusCode == 200) {
          return const Right("Post created successfully");
        } else {
          return Left(ServerFailure(''));
        }
      } else {
        final response = await dio.post(
          'http://35.180.62.182/api/houses/phone/create',
          data: fields,
        );

        if (response.statusCode == 200) {
          return const Right("Post created successfully");
        } else {
          return Left(ServerFailure(''));
        }
      }
    } catch (e) {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(String postId, String userToken) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PostModel>> getPostById(String postId) {
    throw UnimplementedError();
  }



  @override
  Future<Either<Failure, Unit>> updatePost(PostModel postModel) {
    throw UnimplementedError();
  }
}
