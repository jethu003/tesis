import 'package:hive/hive.dart';
part 'add_plants.g.dart';

@HiveType(typeId: 0)
class AddPlantModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? imagePath;

  @HiveField(4)
  String? location;

  AddPlantModel(
      {required this.id,
      required this.description,
      required this.location,
      required this.name,
      required this.imagePath});

  // @override
  // String toString() {
  //   return '$name $description';
  // }
}
