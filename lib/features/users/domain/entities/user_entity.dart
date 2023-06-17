import 'package:equatable/equatable.dart';

import '../../../posts/domain/entities/post_entity.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String phoneNumber;
  final String token;
  final List<Map<String, dynamic>> followers;
  final List<Map<String, dynamic>> following;
  final List<Map<String, dynamic>> likes;
  final List<Map<String, dynamic>> chats;
  final List<PostEntity> posts;

  const UserEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.token,
    required this.followers,
    required this.following,
    required this.likes,
    required this.chats,
    required this.posts,
  });

  @override
  List<Object?> get props =>
      [id, name, phoneNumber, token, followers, following, likes, chats, posts];
}
