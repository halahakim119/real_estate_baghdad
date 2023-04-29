import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';

import '../datasource/user_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl({required this.userDataSource});

  @override
  Future<Either<Failure, UserEntity>> getUser(String id) async {
    try {
      final userModel = await userDataSource.getUser(id);
      return Right(userModel.toEntity());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUser(UserEntity userEntity) async {
    try {
      final userModel = UserModel.fromEntity(userEntity);
      await userDataSource.updateUser(userModel);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
