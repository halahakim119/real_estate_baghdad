import 'package:real_estate_baghdad/features/posts/data/models/post_model.dart';

import '../../../posts/domain/entities/post_entity.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String id,
    required String name,
    required String number,
    required String token,
    List<Map<String, dynamic>> followers = const [],
    List<Map<String, dynamic>> following = const [],
    List<Map<String, dynamic>> likes = const [],
    List<Map<String, dynamic>> chats = const [],
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
          posts: posts,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> postsJson = json['posts'];

    final List<PostModel> posts = postsJson.map((post) {
      return PostModel.fromJson(post);
    }).toList();

    return UserModel(
        id: json['id'] as String,
        name: json['name'] as String,
        number: json['number'] as String,
        token: json['token'] as String,
        followers: List<Map<String, dynamic>>.from(json['followers'] ?? []),
        following: List<Map<String, dynamic>>.from(json['following'] ?? []),
        likes: List<Map<String, dynamic>>.from(json['likes'] ?? []),
        chats: List<Map<String, dynamic>>.from(json['chats'] ?? []),
        posts: posts);
  }

  Map<String, dynamic> toJson() {
    final json = {
      'id': id,
      'name': name,
      'number': number,
      'token': token,
      'followers': followers,
      'following': following,
      'likes': likes,
      'chats': chats,
      'posts': posts.map((post) => post.toJson()).toList(),
    };
    print('Generated JSON: $json');
    return json;
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
      posts: entity.posts,
    );
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
      posts: posts,
    );
  }
}
