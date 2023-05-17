import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../users/domain/entities/user_entity.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasources/authentication_remote_data_source.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;

  AuthenticationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Map<String, String>>> signUpWithPhone({
    required String name,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.signUpWithPhone(
        name: name,
        phoneNumber: phoneNumber,
        password: password,
      );
      return response.fold(
        (failure) => Left(failure),
        (code) => Right(code),
      );
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyPhoneSignUp({
    required String code,
    required String verificationCode,
  }) async {
    try {
      final response = await remoteDataSource.verifyPhoneSignUp(
        code: code,
        verificationCode: verificationCode,
      );
      return response.fold(
          (failure) => Left(failure), (_) => const Right(unit));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithPhone({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await remoteDataSource.signInWithPhone(
        phoneNumber: phoneNumber,
        password: password,
      );
      return response.fold(
        (failure) => Left(failure),
        (userEntity) => Right(userEntity),
      );
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, String>>> resetPassword(
      {required String phoneNumber}) async {
    try {
      final response = await remoteDataSource.resetPassword(
        phoneNumber: phoneNumber,
      );
      return response.fold(
        (failure) => Left(failure),
        (code) => Right(code),
      );
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyPhoneResetPassword({
    required String code,
    required String verificationCode,
    required String newPassword,
  }) async {
    try {
      final response = await remoteDataSource.verifyPhoneResetPassword(
        code: code,
        verificationCode: verificationCode,
        newPassword: newPassword,
      );
      return response.fold(
        (failure) => Left(failure),
        (_) => const Right(unit),
      );
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
