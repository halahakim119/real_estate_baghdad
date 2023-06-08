import 'dart:io';

import 'package:real_estate_baghdad/features/posts/domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  PostModel({
    String? postId,
    required String title,
    List<String>? cords,
    int? likesNum,
    DateTime? dateAdded,
    String? link,
    List<String>? photosURL,
     List<File>? images,
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
    String? userId
  }) : super(
          postId: postId,
          cords: cords,
          title: title,
          likesNum: likesNum,
          dateAdded: dateAdded,
          link: link,
          photosURL: photosURL,
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
          userId:userId
        );

 factory PostModel.fromJson(Map<String, dynamic> json) {
  return PostModel(
    postId: json['id'] as String?,
    title: json['title'] as String,
    cords: (json['coordinates'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
   
    dateAdded: json['createdAt'] != null
        ? DateTime.parse(json['createdAt'] as String)
        : null,
   
    photosURL: List<String>.from(json['photosURL'] ?? []),
    
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
    userId: json['userId'] as String,
    
  );
}

  @override
  Map<String, dynamic> toJson() {
    final json = {
      'title': title,
      'coordinates': cords,
      'id': postId,
      'likes': likesNum,
      'createdAt': dateAdded?.toIso8601String(),
      'photosURL': images!.map((file) => file.path).toList(),
      'province': province,
      'description': overview,
      'furnishing_status': furnishingStatus,
      'type': postType,
      'category': categoryType,
      'bathroom_num': bathroomNum,
      'bedrooms_num': bedroomNum,
      'size': size,
      'price': price,
      'garden': garden,
      'garage': garage,
      'A24h_elecricty': electricity24H,
      'A24h_water': water24H,
      'installed_ac': installedAC,
    };
    print('Generated JSON: $json');
    return json;
  }
}
