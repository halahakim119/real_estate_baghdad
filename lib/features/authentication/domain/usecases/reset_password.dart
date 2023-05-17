import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/authentication_repository.dart';

class ResetPassword {
  final AuthenticationRepository repository;

  ResetPassword(this.repository);

  Future<Either<Failure, bool>> call({
    required String phoneNumber,
  }) async {
    return await repository.resetPassword(
      phoneNumber: phoneNumber,
    );
  }
}
