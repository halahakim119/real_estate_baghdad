import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String uID,
    required String username,
    required String email,
    required String profileImage,
    required String phoneNumber,
    required List followers,
    required List following,
    required List<String> postIds,
  }) : super(
          uID: uID,
          username: username,
          email: email,
          profileImage: profileImage,
          phoneNumber: phoneNumber,
          followers: followers,
          following: following,
          postIds: postIds,
        );

  Map<String, dynamic> toJson() {
    return {
      'uID': uID,
      'username': username,
      'email': email,
      'profileImage': profileImage,
      'phoneNumber': phoneNumber,
      'followers': followers,
      'following': following,
      'postIds': postIds,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uID: json['uID'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      profileImage: json['profileImage'] as String,
      phoneNumber: json['phoneNumber'] as String,
      followers: json['followers'] as List,
      following: json['following'] as List,
      postIds: List<String>.from(json['postIds']),
    );
  }

  UserModel copyWith({
    String? uID,
    String? username,
    String? email,
    String? profileImage,
    String? phoneNumber,
    List? followers,
    List? following,
    List<String>? postIds,
  }) {
    return UserModel(
      uID: uID ?? this.uID,
      username: username ?? this.username,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      postIds: postIds ?? this.postIds,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uID: entity.uID,
      username: entity.username,
      email: entity.email,
      profileImage: entity.profileImage,
      phoneNumber: entity.phoneNumber,
      followers: entity.followers,
      following: entity.following,
      postIds: entity.postIds,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      uID: uID,
      username: username,
      email: email,
      profileImage: profileImage,
      phoneNumber: phoneNumber,
      followers: followers,
      following: following,
      postIds: postIds,
    );
  }
}
