import '../../domain/entities/user_entity.dart';

// class UserModel extends UserEntity {
//   const UserModel({
//     required String uID,
//     required String token,
//     required String username,
//     required String email,
//     required String profileImage,
//     required String phoneNumber,
//     required List followers,
//     required List following,
//     required List<String> postIds,
//   }) : super(
//           uID: uID,
//           token: token,
//           username: username,
//           email: email,
//           profileImage: profileImage,
//           phoneNumber: phoneNumber,
//           followers: followers,
//           following: following,
//           postIds: postIds,
//         );

//   Map<String, dynamic> toJson() {
//     return {
//       'uID': uID,
//       'token': token,
//       'username': username,
//       'email': email,
//       'profileImage': profileImage,
//       'phoneNumber': phoneNumber,
//       'followers': followers,
//       'following': following,
//       'postIds': postIds,
//     };
//   }

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       uID: json['uID'] as String,
//       token: json['token'] as String,
//       username: json['username'] as String,
//       email: json['email'] as String,
//       profileImage: json['profileImage'] as String,
//       phoneNumber: json['phoneNumber'] as String,
//       followers: json['followers'] as List,
//       following: json['following'] as List,
//       postIds: List<String>.from(json['postIds']),
//     );
//   }

//   UserModel copyWith({
//     String? uID,
//     String? token,
//     String? username,
//     String? email,
//     String? profileImage,
//     String? phoneNumber,
//     List? followers,
//     List? following,
//     List<String>? postIds,
//   }) {
//     return UserModel(
//       uID: uID ?? this.uID,
//       token: token ?? this.token,
//       username: username ?? this.username,
//       email: email ?? this.email,
//       profileImage: profileImage ?? this.profileImage,
//       phoneNumber: phoneNumber ?? this.phoneNumber,
//       followers: followers ?? this.followers,
//       following: following ?? this.following,
//       postIds: postIds ?? this.postIds,
//     );
//   }

//   factory UserModel.fromEntity(UserEntity entity) {
//     return UserModel(
//       uID: entity.uID,
//       token: entity.token,
//       username: entity.username,
//       email: entity.email,
//       profileImage: entity.profileImage,
//       phoneNumber: entity.phoneNumber,
//       followers: entity.followers,
//       following: entity.following,
//       postIds: entity.postIds,
//     );
//   }

//   UserEntity toEntity() {
//     return UserEntity(
//       uID: uID,
//       token: token,
//       username: username,
//       email: email,
//       profileImage: profileImage,
//       phoneNumber: phoneNumber,
//       followers: followers,
//       following: following,
//       postIds: postIds,
//     );
//   }
// }

// data/models/user_model.dart

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
  }) : super(
          id: id,
          name: name,
          phoneNumber: number,
          token: token,
          followers: followers,
          following: following,
          likes: likes,
          chats: chats,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number': phoneNumber,
      'token': token,
      'followers': followers,
      'following': following,
      'likes': likes,
      'chats': chats,
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
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? number,
    String? token,
    List? followers,
    List? following,
    List<String>? likes,
    List<String>? chats,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      number: number ?? this.phoneNumber,
      token: token ?? this.token,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      likes: likes ?? this.likes,
      chats: chats ?? this.chats,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      number: entity.phoneNumber,
      token: entity.token,
      followers: entity.followers,
      following: entity.following,
      likes: entity.likes,
      chats: entity.chats,
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
    );
  }
}
