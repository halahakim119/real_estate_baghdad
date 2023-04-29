import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../models/user_model.dart';

abstract class UserDataSource {
  Future<UserModel> getUser(String id);
  Future<void> updateUser(UserModel userModel);
}

class UserDataSourceImpl implements UserDataSource {
  static const BASE_URL = 'https://your-api-url.com';

  @override
  Future<UserModel> getUser(String id) async {
    final response = await http.get(Uri.parse('$BASE_URL/users/$id'));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body) as Map<String, dynamic>;
      return UserModel.fromJson(jsonMap);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> updateUser(UserModel userModel) async {
    final response = await http.put(
      Uri.parse('$BASE_URL/users/${userModel.uID}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userModel.toJson()),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }
}
