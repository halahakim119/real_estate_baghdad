import '../../../posts/data/models/post_model.dart';
import '../../../posts/domain/entities/post_entity.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String name,
    required String phoneNumber,
    required String token,
    required List<Map<String, dynamic>> followers,
    required List<Map<String, dynamic>> following,
    required List<Map<String, dynamic>> likes,
    required List<Map<String, dynamic>> chats,
    required List<PostEntity> posts,
  }) : super(
          id: id,
          name: name,
          phoneNumber: phoneNumber,
          token: token,
          followers: followers,
          following: following,
          likes: likes,
          chats: chats,
          posts: posts,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      token: json['token'],
      followers: List<Map<String, dynamic>>.from(json['followers']),
      following: List<Map<String, dynamic>>.from(json['following']),
      likes: List<Map<String, dynamic>>.from(json['likes']),
      chats: List<Map<String, dynamic>>.from(json['chats']),
      posts: (json['posts'] as List<dynamic>)
          .map((e) => PostModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'token': token,
      'followers': followers,
      'following': following,
      'likes': likes,
      'chats': chats,
      'posts': posts.map((e) => e.toJson()).toList(),
    };
  }

  UserModel fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
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
      phoneNumber: phoneNumber,
      token: token,
      followers: followers,
      following: following,
      likes: likes,
      chats: chats,
      posts: posts,
    );
  }
}
