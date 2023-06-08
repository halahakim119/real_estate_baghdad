import 'package:hive/hive.dart';

import '../../../posts/data/models/post_model.dart';
import '../../../posts/domain/entities/post_entity.dart';
import 'user_model.dart';

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0; // Assign a unique ID for the adapter

  @override
  UserModel read(BinaryReader reader) {
    // Implement the read method to convert binary data to UserModel object
    final fieldsCount = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < fieldsCount; i++) {
      final key = reader.readByte();
      final dynamic value = reader.read();
      fields[key] = value;
    }

    return UserModel(
      id: fields[0] as String,
      name: fields[1] as String,
      number: fields[2] as String,
      token: fields[3] as String,
      followers: List<Map<String, dynamic>>.from(fields[4] as List<dynamic>),
      following: List<Map<String, dynamic>>.from(fields[5] as List<dynamic>),
      likes: List<Map<String, dynamic>>.from(fields[6] as List<dynamic>),
      chats: List<Map<String, dynamic>>.from(fields[7] as List<dynamic>),
      posts: fields[8] != null
          ? List<PostEntity>.from((fields[8] as List<dynamic>)
              .map((post) => PostModel.fromJson(post)))
          : [],
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    // Implement the write method to convert UserModel object to binary data
    writer
      ..writeByte(9) // Number of fields in the UserModel class
      ..writeByte(0) // Field index 0, id
      ..write(obj.id)
      ..writeByte(1) // Field index 1, name
      ..write(obj.name)
      ..writeByte(2) // Field index 2, number
      ..write(obj.number)
      ..writeByte(3) // Field index 3, token
      ..write(obj.token)
      ..writeByte(4) // Field index 4, followers
      ..write(obj.followers)
      ..writeByte(5) // Field index 5, following
      ..write(obj.following)
      ..writeByte(6) // Field index 6, likes
      ..write(obj.likes)
      ..writeByte(7) // Field index 7, chats
      ..write(obj.chats)
      ..writeByte(8) // Field index 8, posts
      ..write(obj.posts);
  }
}
