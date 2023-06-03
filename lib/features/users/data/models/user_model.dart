import 'package:real_estate_baghdad/features/posts/data/models/post_model.dart';

import '../../../posts/domain/entities/post_entity.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String name,
    required String number,
    required String token,
    List followers = const [],
    List following = const [],
    List<String> likes = const [],
    List<String> chats = const [],
    List<PostEntity> posts = const [],
  }) : super(
            id: id,
            name: name,
            number: number,
            token: token,
            followers: followers,
            following: following,
            likes: likes,
            chats: chats,
            posts: posts);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': number,
      'token': token,
      'followers': followers,
      'following': following,
      'likes': likes,
      'chats': chats,
      'posts': posts,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      number: json['number'] as String,
      token: json['token'] as String,
      followers: json['followers'] as List,
      following: json['following'] as List,
      likes: List<String>.from(json['likes']),
      chats: List<String>.from(json['chats']),
      posts: (json['posts'] as List<dynamic>)
          .map((post) => PostModel.fromJson(post))
          .toList(),
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
        id: entity.id,
        name: entity.name,
        number: entity.number,
        token: entity.token,
        followers: entity.followers,
        following: entity.following,
        likes: entity.likes,
        chats: entity.chats,
        posts: entity.posts);
  }

  UserEntity toEntity() {
    return UserEntity(
        id: id,
        name: name,
        number: number,
        token: token,
        followers: followers,
        following: following,
        likes: likes,
        chats: chats,
        posts: posts);
  }
}
