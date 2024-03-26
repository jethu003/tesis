import 'package:hive/hive.dart';
import 'package:tesis/hive_db_functions/hive_models/add_plants.dart';
part 'reminder_model.g.dart';

@HiveType(typeId: 1)
class ReminderModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? plantName;

  @HiveField(2)
  String? reminderName;

  @HiveField(3)
  String? selectedStartDate;

  @HiveField(4)
  String? selectedNotificationTime;

   @HiveField(5)
  String? imagePath;

  

   @HiveField(6)
  AddPlantModel? addPlantModel;

   @HiveField(7)
  String? frequency;

  ReminderModel(
      {required this.id,
      required this.plantName,
      required this.reminderName,
      required this.selectedNotificationTime,
      required this.selectedStartDate,
      required this.imagePath,
      required this.frequency,
      });

  // @override
  // String toString() {
  //   return '$plantName $selectedNotificationTime $selectedStartDate $id';
  // }
}
