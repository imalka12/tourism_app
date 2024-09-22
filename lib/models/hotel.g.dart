// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HotelAdapter extends TypeAdapter<Hotel> {
  @override
  final int typeId = 4;

  @override
  Hotel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Hotel(
      hotelId: fields[0] as int?,
      name: fields[1] as String?,
      description: fields[2] as String?,
      starRating: fields[3] as int?,
      image: fields[4] as String?,
      hotelType: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Hotel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.hotelId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.starRating)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.hotelType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HotelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
