import 'package:dartz/dartz.dart';
import 'package:real_estate_baghdad/features/users/domain/entities/user_entity.dart';

import '../../../../core/error/failure.dart';
import '../repositories/authentication_repository.dart';

class VerifyPhoneSignUp {
  final AuthenticationRepository repository;

  VerifyPhoneSignUp(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String code,
    required String verificationCode,
  }) async {
    final response = await repository.verifyPhoneSignUp(
      code: code,
      verificationCode: verificationCode,
    );
    return response.fold((failure) => Left(failure), (userMap) {
      final user = UserEntity(
        id: userMap.id,
        name: userMap.name,
        phoneNumber: userMap.phoneNumber,
        token: userMap.token,
        followers: userMap.followers,
        following: userMap.following,
        likes: userMap.likes,
        chats: userMap.chats,
      );
      return Right(user);
    });
  }
}
