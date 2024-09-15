// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_room.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HotelRoomAdapter extends TypeAdapter<HotelRoom> {
  @override
  final int typeId = 5;

  @override
  HotelRoom read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HotelRoom(
      roomType: fields[0] as String?,
      mealType: fields[1] as String?,
      numberOfRooms: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HotelRoom obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.roomType)
      ..writeByte(1)
      ..write(obj.mealType)
      ..writeByte(2)
      ..write(obj.numberOfRooms);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HotelRoomAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
