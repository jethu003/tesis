

// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tesis/reminders_screen/reminder_models/reminder_model.dart';

// ignore: constant_identifier_names
const reminder_Db_Name = 'reminder-database';

abstract class ReminderDbFunctions {
  Future<void> addReminder(ReminderModel value);
  Future<List<ReminderModel>> getReminder();

  Future<void> deleteReminders(String reminderId);
  Future<void> updateReminders(ReminderModel updated);
}

class ReminderDb implements ReminderDbFunctions {
  ReminderDb._instance();

  static ReminderDb instance = ReminderDb._instance();

  factory ReminderDb() {
    return instance;
  }

  ValueNotifier<List<ReminderModel>> userAddedReminders = ValueNotifier([]);

  @override
  // ignore: duplicate_ignore
  Future<void> addReminder(ReminderModel value) async {
    final addReminderDb = await Hive.openBox<ReminderModel>(reminder_Db_Name);
    addReminderDb.put(value.id, value);
    
    userAddedReminders.notifyListeners();
  }

  @override
  Future<List<ReminderModel>> getReminder() async {
    final addReminderDb = await Hive.openBox<ReminderModel>(reminder_Db_Name);
    userAddedReminders.notifyListeners();
    return addReminderDb.values.toList();
  }

  Future<void> refreshReminders() async {
    final allReminders = await getReminder();
    userAddedReminders.value.clear();
    Future.forEach(
      allReminders,
      (ReminderModel model) => userAddedReminders.value.add(model),
    );
    userAddedReminders.notifyListeners();
  }

  @override
  Future<void> deleteReminders(String reminderId) async {
    final addReminderDb = await Hive.openBox<ReminderModel>(reminder_Db_Name);
    addReminderDb.delete(reminderId);
    refreshReminders();
    userAddedReminders.notifyListeners();
  }

  @override
  Future<void> updateReminders(ReminderModel value) async {
    final addReminderDb = await Hive.openBox<ReminderModel>(reminder_Db_Name);

    addReminderDb.put(value.id, value);
    refreshReminders();
    userAddedReminders.notifyListeners();
  }
}
