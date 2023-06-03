
import '../../domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  const LocationModel({
    required String locationId,
    required double latitude,
    required double longitude,
    required String name,
    required String description,
  }) : super(
          locationId: locationId,
          latitude: latitude,
          longitude: longitude,
          name: name,
          description: description,
        );

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      locationId: json['locationId'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locationId': locationId,
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
      'description': description,
    };
  }

  LocationModel copyWith({
    String? locationId,
    double? latitude,
    double? longitude,
    String? name,
    String? description,
  }) {
    return LocationModel(
      locationId: locationId ?? this.locationId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
