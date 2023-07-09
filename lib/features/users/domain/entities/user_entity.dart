import 'package:equatable/equatable.dart';

import '../../../posts/domain/entities/post_entity.dart';

class UserEntity extends Equatable {
  final String id;
   String name;
   String phoneNumber;
  final String? token;
  final List<Map<String, dynamic>> followers;
  final List<Map<String, dynamic>> following;
  final List<Map<String, dynamic>> likes;
  final List<Map<String, dynamic>>? chats;
  final List<PostEntity> posts;

   UserEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
     this.token,
    required this.followers,
    required this.following,
    required this.likes,
     this.chats,
    required this.posts,
  });

  @override
  List<Object?> get props =>
      [id, name, phoneNumber, token, followers, following, likes, chats, posts];
}
