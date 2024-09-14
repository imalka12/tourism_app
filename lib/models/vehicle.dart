import 'package:hive_flutter/hive_flutter.dart';

part 'vehicle.g.dart';

@HiveType(typeId: 3)
class Vehicle extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? make;
  @HiveField(2)
  String? model;
  @HiveField(3)
  int? yom;
  @HiveField(4)
  String? trim;
  @HiveField(5)
  String? transmission;
  @HiveField(6)
  String? fuel;
  @HiveField(7)
  int? numberOfSeats;
  @HiveField(8)
  double? pricePerKm;

  Vehicle(
      {this.title,
      this.make,
      this.model,
      this.yom,
      this.trim,
      this.transmission,
      this.fuel,
      this.numberOfSeats,
      this.pricePerKm});

  Vehicle.fromJson(Map<String, dynamic> json) {
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
