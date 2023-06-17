import 'package:hive/hive.dart';

import '../models/user_model.dart';

abstract class UserHiveDataSource {
  UserModel getUserFromBox();
  Future<void> saveUserToBox(UserModel user);
}

class UserHiveDataSourceImpl implements UserHiveDataSource {
  static const String userBoxKey = 'userBox';

  @override
  UserModel getUserFromBox() {
    final userBox = Hive.box<UserModel>(userBoxKey);
    return userBox.get(userBoxKey)!;
  }

  @override
  Future<void> saveUserToBox(UserModel user) async {
    final userBox = Hive.box<UserModel>(userBoxKey);
    await userBox.put(userBoxKey, user);
  }
}
