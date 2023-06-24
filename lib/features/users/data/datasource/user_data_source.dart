import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../authentication/data/datasources/authentication_remote_data_source.dart';
import '../models/user_model.dart';

abstract class UserDataSource {
  Future<Either<Failure, String>> deleteUser(String id, String token);
  Future<Either<Failure, String>> editUser(
      String id, String token, String name);
  Future<Either<Failure, UserModel>> getUser(String id);
  Future<Either<Failure, Map<String, dynamic>>> verifyPhoneNumber(
      String id, String number, String token);
  Future<Either<Failure, String>> updatePhoneNumber(
      String code, String verificationCode);
}

class UserDataSourceImpl implements UserDataSource {
  final Box<UserModel> _userBox;
  Box<Map<String, dynamic>>? _infoBox;
  final AuthenticationRemoteDataSourceImpl authenticationRemoteDataSource;

  UserDataSourceImpl(
      this._userBox, this_infoBox, this.authenticationRemoteDataSource);

  @override
  Future<Either<Failure, String>> deleteUser(String id, String token) async {
    try {
      final response = await http.delete(
        Uri.parse('http://35.180.62.182/api/user/phone/delete'),
        body: {
          'id': id,
          'token': token,
        },
      );

      final jsonResponse = jsonDecode(response.body);
      await _userBox.clear();
      if (response.statusCode == 200 && jsonResponse.containsKey('message')) {
        final phoneNumber = _infoBox!.get('infoBox')!['number'];
        final password = _infoBox!.get('infoBox')!['password'];

        await authenticationRemoteDataSource.signInWithPhone(
            password: password, phoneNumber: phoneNumber);
        return Right(jsonResponse['message']);
      } else if (response.statusCode == 400) {
        if (jsonResponse.containsKey('ERROR')) {
          final errorMessage = jsonResponse['ERROR'];
          return Left(ApiExceptionFailure(errorMessage));
        }
      } else if (response.statusCode == 500) {
        throw ServerFailure('Something went wrong');
      }
      throw ApiException('Failed to delete user');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, String>> editUser(
      String id, String token, String name) async {
    try {
      final response = await http.post(
        Uri.parse('http://35.180.62.182/api/user/phone/edit'),
        body: {'id': id, 'token': token, 'name': name},
      );

      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 && jsonResponse.containsKey('Message')) {
             final phoneNumber = _infoBox!.get('infoBox')!['number'];
        final password = _infoBox!.get('infoBox')!['password'];

        await authenticationRemoteDataSource.signInWithPhone(
            password: password, phoneNumber: phoneNumber);
        return Right(jsonResponse['Message']);
      } else if (response.statusCode == 400) {
        if (jsonResponse.containsKey('ERROR')) {
          final errorMessage = jsonResponse['ERROR'];
          return Left(ApiExceptionFailure(errorMessage));
        }
      } else if (response.statusCode == 500) {
        throw ServerFailure('Something went wrong');
      }
      throw ApiException('Failed to update user name');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUser(String id) async {
    try {
      final response = await http.post(
        Uri.parse('http://35.180.62.182/api/user/phone/getUser'),
        body: {'id': id},
      );

      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 && jsonResponse.containsKey('user')) {
        final userJson = jsonResponse['user'] as Map<String, dynamic>;
        final userData = UserModel.fromJson(userJson);

        return Right(userData);
      } else if (response.statusCode == 400) {
        if (jsonResponse.containsKey('ERROR')) {
          final errorMessage = jsonResponse['ERROR'];
          return Left(ApiExceptionFailure(errorMessage));
        }
      } else if (response.statusCode == 500) {
        throw ServerFailure('Something went wrong');
      }
      throw ApiException('Failed to retrieve user data');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, String>> updatePhoneNumber(
      String code, String verificationCode) async {
    try {
      final response = await http.post(
        Uri.parse('http://35.180.62.182/api/user/phone/number'),
        body: {
          'code': code,
          'verificationCode': verificationCode,
        },
      );

      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 && jsonResponse.containsKey('message')) {
             final phoneNumber = _infoBox!.get('infoBox')!['number'];
        final password = _infoBox!.get('infoBox')!['password'];

        await authenticationRemoteDataSource.signInWithPhone(
            password: password, phoneNumber: phoneNumber);
        return Right(jsonResponse['message']);
      } else if (response.statusCode == 400) {
        if (jsonResponse.containsKey('ERROR')) {
          final errorMessage = jsonResponse['ERROR'];
          return Left(ApiExceptionFailure(errorMessage));
        }
      } else if (response.statusCode == 500) {
        throw ServerFailure('Something went wrong');
      }
      throw ApiException('Failed to update phone number');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> verifyPhoneNumber(
      String id, String number, String token) async {
    try {
      final response = await http.post(
        Uri.parse('http://35.180.62.182/api/user/phone/verify'),
        body: {
          'id': id,
          'number': number,
          'token': token,
        },
      );

      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 &&
          jsonResponse.containsKey('code') &&
          jsonResponse.containsKey('verificationCode')) {
        print(jsonResponse['code']);
        print(jsonResponse['verificationCode']);
        return Right({
          'code': jsonResponse['code'],
          'verificationCode': jsonResponse['verificationCode'],
        });
      } else if (response.statusCode == 400) {
        if (jsonResponse.containsKey('ERROR')) {
          final errorMessage = jsonResponse['ERROR'];
          return Left(ApiExceptionFailure(errorMessage));
        }
      } else if (response.statusCode == 500) {
        throw ServerFailure('Something went wrong');
      }
      throw ApiException('Failed to verify phone number');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }
}
