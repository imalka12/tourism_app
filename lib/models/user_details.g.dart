// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDetailsAdapter extends TypeAdapter<UserDetails> {
  @override
  final int typeId = 2;

  @override
  UserDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDetails(
      firstName: fields[0] as String?,
      lastName: fields[1] as String?,
      numberOfAdults: fields[2] as String?,
      numberOfChildren: fields[3] as String?,
      country: fields[4] as String?,
      email: fields[5] as String?,
      telephone: fields[6] as String?,
      image: fields[7] as String?,
      budget: fields[8] as String?,
      start: fields[9] as String?,
      end: fields[10] as String?,
      totalDays: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDetails obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.numberOfAdults)
      ..writeByte(3)
      ..write(obj.numberOfChildren)
      ..writeByte(4)
      ..write(obj.country)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.telephone)
      ..writeByte(7)
      ..write(obj.image)
      ..writeByte(8)
      ..write(obj.budget)
      ..writeByte(9)
      ..write(obj.start)
      ..writeByte(10)
      ..write(obj.end)
      ..writeByte(11)
      ..write(obj.totalDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
