// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripAdapter extends TypeAdapter<Trip> {
  @override
  final int typeId = 1;

  @override
  Trip read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trip(
      id: fields[0] as String,
      pickup: fields[1] as String,
      drop: fields[2] as String,
      rideType: fields[3] as String,
      fare: fields[4] as double,
      status: fields[5] as String,
      dateTime: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Trip obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.pickup)
      ..writeByte(2)
      ..write(obj.drop)
      ..writeByte(3)
      ..write(obj.rideType)
      ..writeByte(4)
      ..write(obj.fare)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
