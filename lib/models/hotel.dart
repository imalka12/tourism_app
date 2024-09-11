import 'package:hive_flutter/hive_flutter.dart';

part 'hotel.g.dart';

@HiveType(typeId: 4)
class Hotel extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? statRating;

  Hotel({this.name, this.description, this.statRating});

  Hotel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    statRating = json['statRating'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'statRating': statRating
    };
  }
}
