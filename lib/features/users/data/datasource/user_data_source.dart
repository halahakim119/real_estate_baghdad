import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../models/user_model.dart';

abstract class UserDataSource {
  Future<void> deleteUser(String id, String token);
  Future<void> editUser(String id, String token, String name);
  Future<UserModel> getUser(String id);
  Future<void> verifyPhoneNumber(String id, String number, String token);
  Future<void> updatePhoneNumber(String code, String verificationCode);
}

class UserDataSourceImpl implements UserDataSource {
  static const String baseUrl = 'https://your-api-url.com';

  @override
  Future<void> deleteUser(String id, String token) async {
    final url = Uri.parse('$baseUrl/api/user/phone/delete');
    final body = json.encode({'id': id, 'token': token});

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<void> editUser(String id, String token, String name) async {
    final url = Uri.parse('$baseUrl/api/user/phone/edit');
    final body = json.encode({'id': id, 'token': token, 'name': name});

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUser(String id) async {
    final url = Uri.parse('$baseUrl/api/user/phone/getUser');
    final body = json.encode({'id': id});

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body) as Map<String, dynamic>;
      return UserModel.fromJson(jsonMap['user']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> verifyPhoneNumber(String id, String number, String token) async {
    final url = Uri.parse('$baseUrl/api/user/phone/verify');
    final body = json.encode({'id': id, 'number': number, 'token': token});

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body) as Map<String, dynamic>;
      final code = jsonMap['code'] as String;
      final verificationCode = jsonMap['verificationCode'] as String;
      updatePhoneNumber(code, verificationCode);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> updatePhoneNumber(String code, String verificationCode) async {
    final url = Uri.parse('$baseUrl/api/user/phone/number');
    final body =
        json.encode({'code': code, 'verificationCode': verificationCode});

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }
}
