import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../users/domain/entities/user_entity.dart';
import '../repositories/authentication_repository.dart';

class SignInWithPhone {
  final AuthenticationRepository repository;

  SignInWithPhone(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String phoneNumber,
    required String password,
  }) async {
    return await repository.signInWithPhone(
      phoneNumber: phoneNumber,
      password: password,
    );
  }
}
