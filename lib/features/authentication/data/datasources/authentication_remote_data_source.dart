import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/api_provider.dart';
import '../../../users/data/models/user_model.dart';
import '../../../users/domain/entities/user_entity.dart';

abstract class AuthenticationRemoteDataSource {
  Future<Either<Failure, Map<String, String>>> signUpWithPhone({
    required String name,
    required String phoneNumber,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signInWithPhone({
    required String phoneNumber,
    required String password,
  });

  Future<Either<Failure, Unit>> verifyPhoneSignUp({
    required String code,
    required String verificationCode,
  });

  Future<Either<Failure, Map<String, String>>> resetPassword(
      {required String phoneNumber});

  Future<Either<Failure, Unit>> verifyPhoneResetPassword({
    required String code,
    required String verificationCode,
    required String newPassword,
  });
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final Box<UserModel> _userBox;
  final Box<Map<String, dynamic>> _infoBox;
  final ApiProvider _apiProvider;

  AuthenticationRemoteDataSourceImpl(
      this._apiProvider, this._userBox, this._infoBox);

  @override
  Future<Either<Failure, Map<String, String>>> signUpWithPhone({
    required String name,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await _apiProvider.post('signup/phone/verify', {
        'name': name,
        'number': phoneNumber,
        'password': password,
      });

    
      return Right({
        'code': response['code'],
        'verificationCode': response['verificationCode'],
      });
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithPhone({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final jsonResponse = await _apiProvider.post('signin/phone/login', {
        'number': phoneNumber,
        'password': password,
      });

      final userJson = jsonResponse['user'] as Map<String, dynamic>;
      log(userJson.toString());

      final userData = UserModel.fromJson(userJson);

      await _userBox.put('userBox', userData);
     
      return Right(userData.toEntity());
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyPhoneSignUp({
    required String code,
    required String verificationCode,
  }) async {
    try {
      await _apiProvider.post('signup/phone/create', {
        'code': code,
        'verificationCode': verificationCode,
      });
      return const Right(unit);
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, Map<String, String>>> resetPassword(
      {required String phoneNumber}) async {
    try {
      final response = await _apiProvider.post(
        'signin/phone/resetPassword/verify',
        {'number': phoneNumber},
      );

     
      return Right({
        'code': response['code'],
        'verificationCode': response['verificationCode'],
      });
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyPhoneResetPassword({
    required String code,
    required String verificationCode,
    required String newPassword,
  }) async {
    try {
      await _apiProvider.post(
        'signin/phone/resetPassword/resetPassword',
        {
          'code': code,
          'verificationCode': verificationCode,
          'password': newPassword,
        },
      );

      return Right(unit);
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }
}
