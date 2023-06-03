import 'package:equatable/equatable.dart';
import '../../../posts/domain/entities/post_entity.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String number;
  final String token;
  final List followers;
  final List following;
  final List<String> likes;
  final List<String> chats;
  final List<PostEntity> posts;

  const UserEntity({
    required this.id,
    required this.name,
    required this.number,
    required this.token,
    required this.followers,
    required this.following,
    required this.likes,
    required this.chats,
    required this.posts,
  });

  @override
  List<Object?> get props =>
      [id, name, number, token, followers, following, likes, chats, posts];
}
