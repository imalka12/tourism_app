import 'package:hive_flutter/hive_flutter.dart';

part 'user_details.g.dart';

@HiveType(typeId: 2)
class UserDetails extends HiveObject {
  @HiveField(0)
  String? firstName;
  @HiveField(1)
  String? lastName;
  @HiveField(2)
  String? numberOfAdults;
  @HiveField(3)
  String? numberOfChildren;
  @HiveField(4)
  String? country;
  @HiveField(5)
  String? email;
  @HiveField(6)
  String? telephone;
  @HiveField(7)
  String? image;
  @HiveField(8)
  String? budget;
  @HiveField(9)
  String? start;
  @HiveField(10)
  String? end;
  @HiveField(11)
  String? totalDays;

  UserDetails({this.firstName, this.lastName, this.numberOfAdults, this.numberOfChildren, this.country, this.email, this.telephone, this.image, this.budget, this.start, this.end, this.totalDays});

  UserDetails.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    numberOfAdults = '${json['numberOfAdults']}';
    numberOfChildren = '${json['numberOfChildren']}';
    country = json['country'];
    email = json['email'];
    telephone = json['telephone'];
    image = json['image'];
    budget = '${json['budget']}';
    totalDays = '${json['totalDays']}';
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'numberOfAdults': numberOfAdults,
      'numberOfChildren': numberOfChildren,
      'country': country,
      'email': email,
      'telephone': telephone,
      'image': image,
      'budget': budget,
      'totalDays': totalDays,
      'start': start,
      'end': end,
    };
  }
}
