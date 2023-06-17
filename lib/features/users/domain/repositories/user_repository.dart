import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUser(String id);
  // Future<Either<Failure, Unit>> updateUser(UserEntity userEntity);
}
