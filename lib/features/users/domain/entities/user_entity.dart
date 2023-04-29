import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uID;
  final String username;
  final String email;
  final String profileImage;
  final String phoneNumber;
  final List followers;
  final List following;
  final List<String> postIds;

  const UserEntity(
      {required this.uID,
      required this.username,
      required this.email,
      required this.profileImage,
      required this.phoneNumber,
      required this.followers,
      required this.following,
      required this.postIds});

  @override
  List<Object?> get props => [
        uID,
        username,
        email,
        profileImage,
        phoneNumber,
        followers,
        following,
        postIds
      ];
}
