import 'dart:io';

import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String? id;
  final String title;
  final List<File>? images;
  final int price;
  final List<String>? photosURL;
  final int size;
  final String description;
  final List<dynamic>? coordinates;
  final String province;
  final String? type;
  final int bathroomNumber;
  final int bedroomNumber;
  final bool? garden;
  final bool? garage;
  final bool? swimmingPool;
  final bool? electricity24h;
  final bool? water24h;
  final String category;
  final bool? installedAC;
  final String? furnishingStatus;
  final DateTime? createdAt;
  final String? userId;
  final Map<String, dynamic>? seller;
  final List<dynamic>? likeby;

  const PostEntity({
    required this.title,
    required this.price,
    required this.size,
    required this.description,
    required this.province,
    required this.bathroomNumber,
    required this.bedroomNumber,
    required this.category,
    this.id,
    this.photosURL,
    this.coordinates,
    this.type,
    this.images,
    this.garden,
    this.garage,
    this.swimmingPool,
    this.electricity24h,
    this.water24h,
    this.installedAC,
    this.furnishingStatus,
    this.createdAt,
    this.userId,
    this.seller,
    this.likeby,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        photosURL,
        size,
        description,
        coordinates,
        province,
        type,
        bathroomNumber,
        bedroomNumber,
        garden,
        garage,
        swimmingPool,
        electricity24h,
        water24h,
        category,
        installedAC,
        furnishingStatus,
        createdAt,
        userId,
        seller,
        likeby,
      ];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'photosURL': photosURL,
      'size': size,
      'description': description,
      'coordinates': coordinates,
      'province': province,
      'type': type,
      'bathroomNumber': bathroomNumber,
      'bedroomNumber': bedroomNumber,
      'garden': garden,
      'garage': garage,
      'swimmingPool': swimmingPool,
      'electricity24h': electricity24h,
      'water24h': water24h,
      'category': category,
      'installedAC': installedAC,
      'furnishingStatus': furnishingStatus,
      'createdAt': createdAt!.toIso8601String()??'',
      'userId': userId,
      'seller': seller,
      'likeby': likeby,
    };
  }
}
