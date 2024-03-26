// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tesis/hive_db_functions/hive_models/add_plants.dart';
// import 'package:flutter/src/foundation/change_notifier.dart';

// ignore: constant_identifier_names
const addplants_Db_Name = 'addplants-database';

abstract class AddPlantsDbFunctions {
  Future<List<AddPlantModel>> getPlants();

  Future<void> insertPlants(AddPlantModel value);

  Future<void> deletePlantDetais(String plantsId);

  Future<void> updatePlantdetails(AddPlantModel updated);
}

class AddPlantsDb implements AddPlantsDbFunctions {
  AddPlantsDb._internal();

  static AddPlantsDb instance = AddPlantsDb._internal();

  factory AddPlantsDb() {
    return instance;
  }

  ValueNotifier<List<AddPlantModel>> userAddedplants = ValueNotifier([]);

  @override
  Future<void> insertPlants(AddPlantModel value) async {
    final addPlantsDB = await Hive.openBox<AddPlantModel>(addplants_Db_Name);
    await addPlantsDB.put(value.id, value);
    reFreshdata();
  }

  @override
  Future<List<AddPlantModel>> getPlants() async {
    final addPlantsDB = await Hive.openBox<AddPlantModel>(addplants_Db_Name);

    final plants = addPlantsDB.values.toList();

    return plants;
  }

  Future<void> reFreshdata() async {
    final allPlants = await getPlants();
    userAddedplants.value.clear();
    await Future.forEach(
        allPlants, (AddPlantModel model) => userAddedplants.value.add(model));

    userAddedplants.notifyListeners();
  }

  @override
  Future<void> deletePlantDetais(String plantsId) async {
    final addPlantsDB = await Hive.openBox<AddPlantModel>(addplants_Db_Name);
    addPlantsDB.delete(plantsId);
    await reFreshdata();
    userAddedplants.notifyListeners();
  }

  @override
  Future<void> updatePlantdetails(AddPlantModel value) async {
    final addPlantsDB = await Hive.openBox<AddPlantModel>(addplants_Db_Name);
    addPlantsDB.put(value.id, value);
    await reFreshdata();
    userAddedplants.notifyListeners();
  }
}
