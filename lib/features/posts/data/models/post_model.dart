import 'dart:io';

import '../../domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  PostModel({
    String? id,
    required String title,
    required int price,
    required int size,
    required String description,
    required int bathroomNumber,
    required int bedroomNumber,
    required String province,
    required String category,
    List<File>? images,
    List<String>? photosURL,
    List<dynamic>? coordinates,
    String? type,
    bool? garden,
    bool? garage,
    bool? swimmingPool,
    bool? electricity24h,
    bool? water24h,
    bool? installedAC,
    String? furnishingStatus,
    DateTime? createdAt,
    String? userId,
    Map<String, dynamic>? seller,
    List<dynamic>? likeby,
  }) : super(
          id: id,
          images: images,
          title: title,
          price: price,
          photosURL: photosURL,
          size: size,
          description: description,
          coordinates: coordinates,
          province: province,
          type: type,
          bathroomNumber: bathroomNumber,
          bedroomNumber: bedroomNumber,
          garden: garden,
          garage: garage,
          swimmingPool: swimmingPool,
          electricity24h: electricity24h,
          water24h: water24h,
          category: category,
          installedAC: installedAC,
          furnishingStatus: furnishingStatus,
          createdAt: createdAt,
          userId: userId,
          seller: seller,
          likeby: likeby,
        );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      size: json['size'],
      description: json['description'],
      bathroomNumber: json['bathroomNumber'],
      bedroomNumber: json['bedroomNumber'],
      province: json['province'],
      category: json['category'],
      images: (json['images'] as List<dynamic>?)?.map((e) => File(e)).toList(),
      photosURL: (json['photosURL'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      coordinates: json['coordinates'],
      type: json['type'],
      garden: json['garden'],
      garage: json['garage'],
      swimmingPool: json['swimmingPool'],
      electricity24h: json['electricity24h'],
      water24h: json['water24h'],
      installedAC: json['installedAC'],
      furnishingStatus: json['furnishingStatus'],
      createdAt: DateTime.parse(json['createdAt']),
      userId: json['userId'],
      seller: json['seller'],
      likeby: json['likeby'],
    );
  }

  
  factory PostModel.fromJsonUpdate(Map<String, dynamic> json) {
  return PostModel(
    id: json['post']['id'],
    title: json['post']['title'],
    price: json['post']['price'],
    photosURL: (json['post']['photosURL'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList(),
    size: json['post']['size'],
    description: json['post']['description'],
    coordinates: List<String>.from(json['post']['coordinates']),
    province: json['post']['province'],
    type: json['post']['type'],
    bathroomNumber: json['post']['bathroomNumber'],
    bedroomNumber: json['post']['bedroomNumber'],
    garden: json['post']['garden'],
    garage: json['post']['garage'],
    swimmingPool: json['post']['swimmingPool'],
    electricity24h: json['post']['electricity24h'],
    water24h: json['post']['water24h'],
    category: json['post']['category'],
    installedAC: json['post']['installedAC'],
    furnishingStatus: json['post']['furnishingStatus'],
    createdAt: DateTime.parse(json['post']['createdAt']),
    userId: json['post']['userId'],
  );
}



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'size': size,
      'description': description,
      'bathroomNumber': bathroomNumber,
      'bedroomNumber': bedroomNumber,
      'province': province,
      'category': category,
      'images': images?.map((e) => e.path).toList(),
      'photosURL': photosURL,
      'coordinates': coordinates,
      'type': type,
      'garden': garden,
      'garage': garage,
      'swimmingPool': swimmingPool,
      'electricity24h': electricity24h,
      'water24h': water24h,
      'installedAC': installedAC,
      'furnishingStatus': furnishingStatus,
      'createdAt': createdAt?.toIso8601String(),
      'userId': userId,
      'seller': seller,
      'likeby': likeby,
    };
  }

  factory PostModel.fromEntity(PostEntity entity) {
    return PostModel(
      id: entity.id,
      title: entity.title,
      price: entity.price,
      size: entity.size,
      description: entity.description,
      bathroomNumber: entity.bathroomNumber,
      bedroomNumber: entity.bedroomNumber,
      province: entity.province,
      category: entity.category,
      images: entity.images,
      photosURL: entity.photosURL,
      coordinates: entity.coordinates,
      type: entity.type,
      garden: entity.garden,
      garage: entity.garage,
      swimmingPool: entity.swimmingPool,
      electricity24h: entity.electricity24h,
      water24h: entity.water24h,
      installedAC: entity.installedAC,
      furnishingStatus: entity.furnishingStatus,
      createdAt: entity.createdAt,
      userId: entity.userId,
      seller: entity.seller,
      likeby: entity.likeby,
    );
  }

  PostEntity toEntity() {
    return PostEntity(
      id: id,
      title: title,
      price: price,
      size: size,
      description: description,
      bathroomNumber: bathroomNumber,
      bedroomNumber: bedroomNumber,
      province: province,
      category: category,
      images: images,
      photosURL: photosURL,
      coordinates: coordinates,
      type: type,
      garden: garden,
      garage: garage,
      swimmingPool: swimmingPool,
      electricity24h: electricity24h,
      water24h: water24h,
      installedAC: installedAC,
      furnishingStatus: furnishingStatus,
      createdAt: createdAt,
      userId: userId,
      seller: seller,
      likeby: likeby,
    );
  }
}
