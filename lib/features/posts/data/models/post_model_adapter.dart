import 'dart:io';

import 'package:hive/hive.dart';

import '../models/post_model.dart';

class PostModelAdapter extends TypeAdapter<PostModel> {
  @override
  final int typeId = 1; // Assign a unique ID for the adapter

  @override
  PostModel read(BinaryReader reader) {
    // Implement the read method to convert binary data to PostModel object
    final fieldsCount = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < fieldsCount; i++) {
      final key = reader.readByte();
      final dynamic value = reader.read();
      fields[key] = value;
    }

    return PostModel(
      id: fields[0] as String?,
      title: fields[1] as String,
      price: fields[2] as int,
      size: fields[3] as int,
      description: fields[4] as String,
      bathroomNumber: fields[5] as int,
      bedroomNumber: fields[6] as int,
      province: fields[7] as String,
      category: fields[8] as String,
      images: fields[9] as List<File>?,
      photosURL: fields[10] as List<String>?,
      coordinates: fields[11] as List<dynamic>?,
      type: fields[12] as String?,
      garden: fields[13] as bool?,
      garage: fields[14] as bool?,
      swimmingPool: fields[15] as bool?,
      electricity24h: fields[16] as bool?,
      water24h: fields[17] as bool?,
      installedAC: fields[18] as bool?,
      furnishingStatus: fields[19] as String?,
      createdAt: fields[20] as DateTime?,
      userId: fields[21] as String?,
      seller: fields[22] as Map<String, dynamic>?,
      likeby: fields[23] as List<dynamic>?,
    );
  }

  @override
  void write(BinaryWriter writer, PostModel obj) {
    // Implement the write method to convert PostModel object to binary data
    writer
      ..writeByte(24) // Number of fields in the PostModel class
      ..writeByte(0) // Field index 0, id
      ..write(obj.id)
      ..writeByte(1) // Field index 1, title
      ..write(obj.title)
      ..writeByte(2) // Field index 2, price
      ..write(obj.price)
      ..writeByte(3) // Field index 3, size
      ..write(obj.size)
      ..writeByte(4) // Field index 4, description
      ..write(obj.description)
      ..writeByte(5) // Field index 5, bathroomNumber
      ..write(obj.bathroomNumber)
      ..writeByte(6) // Field index 6, bedroomNumber
      ..write(obj.bedroomNumber)
      ..writeByte(7) // Field index 7, province
      ..write(obj.province)
      ..writeByte(8) // Field index 8, category
      ..write(obj.category)
      ..writeByte(9) // Field index 9, images
      ..write(obj.images)
      ..writeByte(10) // Field index 10, photosURL
      ..write(obj.photosURL)
      ..writeByte(11) // Field index 11, coordinates
      ..write(obj.coordinates)
      ..writeByte(12) // Field index 12, type
      ..write(obj.type)
      ..writeByte(13) // Field index 13, garden
      ..write(obj.garden)
      ..writeByte(14) // Field index 14, garage
      ..write(obj.garage)
      ..writeByte(15) // Field index 15, swimmingPool
      ..write(obj.swimmingPool)
      ..writeByte(16) // Field index 16, electricity24h
      ..write(obj.electricity24h)
      ..writeByte(17) // Field index 17, water24h
      ..write(obj.water24h)
      ..writeByte(18) // Field index 18, installedAC
      ..write(obj.installedAC)
      ..writeByte(19) // Field index 19, furnishingStatus
      ..write(obj.furnishingStatus)
      ..writeByte(20) // Field index 20, createdAt
      ..write(obj.createdAt)
      ..writeByte(21) // Field index 21, userId
      ..write(obj.userId)
      ..writeByte(22) // Field index 22, seller
      ..write(obj.seller)
      ..writeByte(23) // Field index 23, likeby
      ..write(obj.likeby);
  }
}
