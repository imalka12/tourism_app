import 'package:hive_flutter/hive_flutter.dart';

part 'hotel_room.g.dart';

@HiveType(typeId: 5)
class HotelRoom extends HiveObject {
  @HiveField(0)
  String? roomType;
  @HiveField(1)
  String? mealType;
  @HiveField(2)
  String? numberOfRooms;

  HotelRoom({this.roomType, this.mealType, this.numberOfRooms});

  HotelRoom.fromJson(Map<String, dynamic> json) {
    roomType = json['roomType'];
    mealType = json['mealType'];
    numberOfRooms = json['numberOfRooms'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'roomType': roomType,
      'mealType': mealType,
      'numberOfRooms': numberOfRooms,
    };
  }
}
