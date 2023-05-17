import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../users/domain/entities/user_entity.dart';
import '../repositories/authentication_repository.dart';

class VerifyPhoneResetPassword {
  final AuthenticationRepository repository;

  VerifyPhoneResetPassword(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String code,
    required String verificationCode,
    required String newPassword,
  }) async {
    return await repository.verifyPhoneResetPassword(
      code: code,
      verificationCode: verificationCode,
      newPassword: newPassword,
    );
  }
}
