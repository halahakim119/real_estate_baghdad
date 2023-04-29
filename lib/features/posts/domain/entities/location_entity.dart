import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final String locationId;
  final double latitude;
  final double longitude;
  final String name;
  final String description;

  const LocationEntity({
    required this.locationId,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props =>
      [locationId, latitude, longitude, name, description];
}
