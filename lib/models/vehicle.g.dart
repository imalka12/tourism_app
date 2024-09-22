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
      id: fields[0] as int?,
      title: fields[1] as String?,
      make: fields[2] as String?,
      model: fields[3] as String?,
      yom: fields[4] as int?,
      trim: fields[5] as String?,
      transmission: fields[6] as String?,
      fuel: fields[7] as String?,
      numberOfSeats: fields[8] as int?,
      pricePerKm: fields[9] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Vehicle obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.make)
      ..writeByte(3)
      ..write(obj.model)
      ..writeByte(4)
      ..write(obj.yom)
      ..writeByte(5)
      ..write(obj.trim)
      ..writeByte(6)
      ..write(obj.transmission)
      ..writeByte(7)
      ..write(obj.fuel)
      ..writeByte(8)
      ..write(obj.numberOfSeats)
      ..writeByte(9)
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
