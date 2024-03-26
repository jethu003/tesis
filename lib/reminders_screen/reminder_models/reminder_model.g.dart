// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderModelAdapter extends TypeAdapter<ReminderModel> {
  @override
  final int typeId = 1;

  @override
  ReminderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderModel(
      id: fields[0] as String?,
      plantName: fields[1] as String?,
      reminderName: fields[2] as String?,
      selectedNotificationTime: fields[4] as String?,
      selectedStartDate: fields[3] as String?,
      imagePath: fields[5] as String?,
      frequency: fields[7] as String?,
    )..addPlantModel = fields[6] as AddPlantModel?;
  }

  @override
  void write(BinaryWriter writer, ReminderModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.plantName)
      ..writeByte(2)
      ..write(obj.reminderName)
      ..writeByte(3)
      ..write(obj.selectedStartDate)
      ..writeByte(4)
      ..write(obj.selectedNotificationTime)
      ..writeByte(5)
      ..write(obj.imagePath)
      ..writeByte(6)
      ..write(obj.addPlantModel)
      ..writeByte(7)
      ..write(obj.frequency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
