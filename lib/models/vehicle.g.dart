// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicleAdapter extends TypeAdapter<Vehicle> {
  @override
  final int typeId = 3;

  @override
  Vehicle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vehicle(
      title: fields[0] as String?,
      make: fields[1] as String?,
      model: fields[2] as String?,
      yom: fields[3] as int?,
      trim: fields[4] as String?,
      transmission: fields[5] as String?,
      fuel: fields[6] as String?,
      numberOfSeats: fields[7] as int?,
      pricePerKm: fields[8] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Vehicle obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.make)
      ..writeByte(2)
      ..write(obj.model)
      ..writeByte(3)
      ..write(obj.yom)
      ..writeByte(4)
      ..write(obj.trim)
      ..writeByte(5)
      ..write(obj.transmission)
      ..writeByte(6)
      ..write(obj.fuel)
      ..writeByte(7)
      ..write(obj.numberOfSeats)
      ..writeByte(8)
      ..write(obj.pricePerKm);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
