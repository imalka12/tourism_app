import 'package:hive_flutter/hive_flutter.dart';

part 'vehicle.g.dart';

@HiveType(typeId: 3)
class Vehicle extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? make;
  @HiveField(3)
  String? model;
  @HiveField(4)
  int? yom;
  @HiveField(5)
  String? trim;
  @HiveField(6)
  String? transmission;
  @HiveField(7)
  String? fuel;
  @HiveField(8)
  int? numberOfSeats;
  @HiveField(9)
  double? pricePerKm;

  Vehicle(
      {this.id,
      this.title,
      this.make,
      this.model,
      this.yom,
      this.trim,
      this.transmission,
      this.fuel,
      this.numberOfSeats,
      this.pricePerKm});

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    make = json['make'];
    model = json['model'];
    yom = json['yom'];
    trim = json['trim'];
    transmission = json['transmission'];
    fuel = json['fuel'];
    numberOfSeats = json['numberOfSeats'];
    pricePerKm = json['pricePerKm'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'make': make,
      'model': model,
      'yom': yom,
      'trim': trim,
      'transmission': transmission,
      'fuel': fuel,
      'numberOfSeats': numberOfSeats,
      'pricePerKm': pricePerKm,
    };
  }
}
