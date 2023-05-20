import 'package:equatable/equatable.dart';

// class UserEntity extends Equatable {
//   final String uID;
//   final String token;
//   final String username;
//   final String email;
//   final String profileImage;
//   final String phoneNumber;
//   final List followers;
//   final List following;
//   final List<String> postIds;

//   const UserEntity(
//       {required this.uID,
//       required this.token,
//       required this.username,
//       required this.email,
//       required this.profileImage,
//       required this.phoneNumber,
//       required this.followers,
//       required this.following,
//       required this.postIds});

//   @override
//   List<Object?> get props => [
//         uID,
//         token,
//         username,
//         email,
//         profileImage,
//         phoneNumber,
//         followers,
//         following,
//         postIds
//       ];
// }

// domain/entities/user_entity.dart

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String number;
  final String token;
  final List followers;
  final List following;
  final List<String> likes;
  final List<String> chats;

  const UserEntity({
    required this.id,
    required this.name,
    required this.number,
    required this.token,
    required this.followers,
    required this.following,
    required this.likes,
    required this.chats,
  });

  @override
  List<Object?> get props =>
      [id, name, number, token, followers, following, likes, chats];
}
