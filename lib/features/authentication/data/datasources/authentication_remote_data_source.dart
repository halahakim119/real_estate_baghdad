import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

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
  final ApiProvider _apiProvider;

  AuthenticationRemoteDataSourceImpl(this._apiProvider);

  @override
  Future<Either<Failure, Map<String, String>>> signUpWithPhone({
    required String name,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://35.180.62.182/api/signup/phone/verify'),
        body: {
          'name': name,
          'number': phoneNumber,
          'password': password,
        },
      );
      final jsonResponse = jsonDecode(response.body);
      return Right({
        'code': jsonResponse['code'],
        'verificationCode': jsonResponse['verificationCode'],
      });
    } catch (e) {
      return Left(ServerFailure());
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
      return Right(UserModel.fromJson(jsonResponse['user']).toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyPhoneSignUp({
    required String code,
    required String verificationCode,
  }) async {
    try {
      final jsonResponse = await http.post(
        Uri.parse('http://35.180.62.182/api/signup/phone/create'),
        body: {
          'code': code,
          'verificationCode': verificationCode,
        },
      );

      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, String>>> resetPassword(
      {required String phoneNumber}) async {
    try {
      final response =await http.post(
        Uri.parse('http://35.180.62.182/api/signin/phone/resetPassword/verify'),
        body: {
            'number': phoneNumber,
        },
      );

      final jsonResponse = jsonDecode(response.body);
      return Right({
        'code': jsonResponse['code'],
        'verificationCode': jsonResponse['verificationCode'],
      });
    } catch (e) {
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
      final jsonResponse =
       await http.post(
        Uri.parse('http://35.180.62.182/api/signin/phone/resetPassword/resetPassword'),
        body: {
        'code': code,
        'verificationCode': verificationCode,
        'password': newPassword,
        },
      );
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
