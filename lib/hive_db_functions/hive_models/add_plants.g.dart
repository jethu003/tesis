// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_plants.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddPlantModelAdapter extends TypeAdapter<AddPlantModel> {
  @override
  final int typeId = 0;

  @override
  AddPlantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddPlantModel(
      id: fields[0] as String?,
      description: fields[2] as String?,
      location: fields[4] as String?,
      name: fields[1] as String?,
      imagePath: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AddPlantModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.imagePath)
      ..writeByte(4)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddPlantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
