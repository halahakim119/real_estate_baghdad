import 'dart:io';

import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  String? postId;
  final String title;
  int? likesNum;
  DateTime? dateAdded;
  String? link;
  List<String>? photosURL;
  List<File>? images;
  final String province;
  final String overview;
  final String furnishingStatus;
  final String postType;
  final String categoryType;
  final int bathroomNum;
  final int bedroomNum;
  List<String>? cords;
  final double size;
  final double price;
  final bool garden;
  final bool garage;
  final bool electricity24H;
  final bool water24H;
  final bool installedAC;
  String? userId;

  PostEntity(
      {this.postId,
      this.cords,
      required this.title,
      this.likesNum,
      this.dateAdded,
      this.link,
      this.photosURL,
      this.images,
      required this.province,
      required this.overview,
      required this.furnishingStatus,
      required this.postType,
      required this.categoryType,
      required this.bathroomNum,
      required this.bedroomNum,
      required this.size,
      required this.price,
      required this.garden,
      required this.garage,
      required this.electricity24H,
      required this.water24H,
      required this.installedAC,
      this.userId});

  @override
  List<Object?> get props => [
        postId,
        likesNum,
        dateAdded,
        cords,
        title,
        link,
        photosURL,
        images,
        province,
        overview,
        furnishingStatus,
        postType,
        categoryType,
        bathroomNum,
        bedroomNum,
        size,
        price,
        garage,
        garden,
        electricity24H,
        water24H,
        installedAC,
        userId
      ];
  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'title': title,
      'photosURL': photosURL,
      'likesNum': likesNum,
      'dateAdded': dateAdded?.toIso8601String(),
      'link': link,
      'images': images!.map((file) => file.path).toList(),
      'province': province,
      'overview': overview,
      'furnishingStatus': furnishingStatus,
      'postType': postType,
      'categoryType': categoryType,
      'bathroomNum': bathroomNum,
      'bedroomNum': bedroomNum,
      'cords': cords,
      'size': size,
      'price': price,
      'garden': garden,
      'garage': garage,
      'electricity24H': electricity24H,
      'water24H': water24H,
      'installedAC': installedAC,
      'userId': userId
    };
  }
}
