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
  String? statRating;
  @HiveField(4)
  String? image;

  Hotel({
    this.hotelId,
    this.name,
    this.description,
    this.statRating,
    this.image,
  });

  Hotel.fromJson(Map<String, dynamic> json) {
    hotelId = json['hotel_id'];
    name = json['name'];
    description = json['description'];
    statRating = json['stat_rating'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'hotel_id': hotelId,
      'name': name,
      'description': description,
      'stat_rating': statRating,
      'image': image,
    };
  }
}
