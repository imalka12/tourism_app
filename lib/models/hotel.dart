import 'package:hive_flutter/hive_flutter.dart';

part 'hotel.g.dart';

@HiveType(typeId: 4)
class Hotel extends HiveObject {
  @HiveField(0)
  int? hotelId;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? description;
  @HiveField(3)
  int? starRating;
  @HiveField(4)
  String? image;
  @HiveField(5)
  String? hotelType;

  Hotel({
    this.hotelId,
    this.name,
    this.description,
    this.starRating,
    this.image,
    this.hotelType,
  });

  Hotel.fromJson(Map<String, dynamic> json) {
    hotelId = json['hotel_id'];
    name = json['name'];
    description = json['description'];
    starRating = json['star_rating'];
    image = json['image'];
    hotelType = json['hotel_type'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'hotel_id': hotelId,
      'name': name,
      'description': description,
      'star_rating': starRating,
      'image': image,
      'hotel_type': hotelType,
    };
  }
}
