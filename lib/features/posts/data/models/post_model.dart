import 'dart:io';

import '../../domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  PostModel({
    String? postId,
    required String title,
     List<String>? cords,
    int? likesNum,
    DateTime? dateAdded,
    String? link,
    required List<File> images,
    required String province,
    required String overview,
    required String furnishingStatus,
    required String postType,
    required String categoryType,
    required int bathroomNum,
    required int bedroomNum,
    required double size,
    required double price,
    required bool garden,
    required bool garage,
    required bool electricity24H,
    required bool water24H,
    required bool installedAC,
  }) : super(
          postId: postId,
          cords: cords,
          title: title,
          likesNum: likesNum,
          dateAdded: dateAdded,
          link: link,
          images: images,
          province: province,
          overview: overview,
          furnishingStatus: furnishingStatus,
          postType: postType,
          categoryType: categoryType,
          bathroomNum: bathroomNum,
          bedroomNum: bedroomNum,
          size: size,
          price: price,
          garden: garden,
          garage: garage,
          electricity24H: electricity24H,
          water24H: water24H,
          installedAC: installedAC,
        );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      title: json['title'] as String,
      cords: (json['cords'] as List<String>).map((e) => e as String).toList(),
      postId: json['postId'] as String,
      likesNum: json['likesNum'] as int,
      dateAdded: DateTime.parse(json['dateAdded'] as String),
      link: json['link'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as File).toList(),
      province: json['province'] as String,
      overview: json['overview'] as String,
      furnishingStatus: json['furnishingStatus'] as String,
      postType: json['postType'] as String,
      categoryType: json['categoryType'] as String,
      bathroomNum: json['bathroomNum'] as int,
      bedroomNum: json['bedroomNum'] as int,
      size: json['size'] as double,
      price: json['price'] as double,
      garden: json['garden'] as bool,
      garage: json['garage'] as bool,
      electricity24H: json['electricity24H'] as bool,
      water24H: json['water24H'] as bool,
      installedAC: json['installedAC'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'likesNum': likesNum,
      'cords': cords,
      'title': title,
      'dateAdded': dateAdded?.toIso8601String(),
      'link': link,
      'images': images,
      'province': province,
      'overview': overview,
      'furnishingStatus': furnishingStatus,
      'postType': postType,
      'categoryType': categoryType,
      'bathroomNum': bathroomNum,
      'bedroomNum': bedroomNum,
      'size': size,
      'price': price,
      'garden': garden,
      'garage': garage,
      'electricity24H': electricity24H,
      'water24H': water24H,
      'installedAC': installedAC,
    };
  }
}
