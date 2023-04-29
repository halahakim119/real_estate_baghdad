import 'package:equatable/equatable.dart';

import 'location_entity.dart';

class PostEntity extends Equatable {
  final String userId;
  final String postId;
  final int likesNum;
  final DateTime dateAdded;
  final String link;
  final List<String> images;
  final LocationEntity location;
  final String overview;
  final String furnishingStatus;
  final String postType;
  final String categoryType;
  final String titleDeedType;
  final int bathroomNum;
  final int bedroomNum;
  final double size;
  final double price;
  final bool garden;
  final bool garage;
  final bool swimmingpool;
  final bool electricity24H;
  final bool water24H;
  final bool installedAC;
  final bool dualTitleDeed;
  const PostEntity({
    required this.userId,
    required this.postId,
    required this.likesNum,
    required this.dateAdded,
    required this.link,
    required this.images,
    required this.location,
    required this.overview,
    required this.furnishingStatus,
    required this.postType,
    required this.categoryType,
    required this.titleDeedType,
    required this.bathroomNum,
    required this.bedroomNum,
    required this.size,
    required this.price,
    required this.garden,
    required this.garage,
    required this.swimmingpool,
    required this.electricity24H,
    required this.water24H,
    required this.installedAC,
    required this.dualTitleDeed,
  });

  @override
  List<Object?> get props => [
        userId,
        postId,
        likesNum,
        dateAdded,
        link,
        images,
        location,
        overview,
        furnishingStatus,
        postType,
        categoryType,
        titleDeedType,
        bathroomNum,
        bedroomNum,
        size,
        price,
        garage,
        garden,
        swimmingpool,
        electricity24H,
        water24H,
        installedAC,
        dualTitleDeed
      ];
}
