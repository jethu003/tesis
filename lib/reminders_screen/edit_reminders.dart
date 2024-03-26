import 'package:flutter/material.dart';
import 'package:tesis/loginScreens/common_widgets.dart';
import 'package:tesis/reminders_screen/alert_dialogue.dart';
import 'package:tesis/reminders_screen/listtile_reminders.dart';
import 'package:tesis/reminders_screen/reminder_db_functions/reminder_db_functions.dart';
import 'package:tesis/reminders_screen/reminder_models/reminder_model.dart';
import 'package:tesis/reminders_screen/reminders_list.dart';
import 'package:tesis/utilis/app_colors.dart';

class EditReminders extends StatefulWidget {
  final String plants;
  final String imagePath;
  final String selectedDate;
  final String selectedNotification;
  final String selectedAction;
  final String selectedFrequency;
  final String id;

  const EditReminders({
    Key? key,
    required this.plants,
    required this.imagePath,
    required this.selectedDate,
    required this.selectedNotification,
    required this.selectedAction,
    required this.selectedFrequency,
    required this.id,
  }) : super(key: key);

  @override
  State<EditReminders> createState() => _EditRemindersState();
}

class _EditRemindersState extends State<EditReminders> {
  final CommonWidgets common = CommonWidgets();
  DateTime? selectedStartDate;
  TimeOfDay? selectedNotificationTime;
  String? selectedAction;
  late String selectedFrequency;

  @override
  void initState() {
    super.initState();

    selectedFrequency = widget.selectedFrequency;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 10,
        title: Row(
          children: [
            common.buildRichText(
              firstText: 'Edit ',
              firstTextStyle: const TextStyle(
                letterSpacing: 2,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryColor,
                fontFamily: 'Schyler',
              ),
              secondText: 'Reminders',
              secondTextStyle: const TextStyle(
                letterSpacing: 2,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryColor,
                fontFamily: 'Schyler',
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.backGroundColor,
        centerTitle: false,
      ),
      body: Container(
        color: AppColors.backGroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              MyListTile(
                leading: const Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryColor,
                    fontFamily: 'Schyler',
                  ),
                ),
                trailing: Text(
                  widget.plants,
                  style: const TextStyle(
                    fontSize: 18,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryColor,
                    fontFamily: 'Schyler',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyListTile(
                leading: const Text(
                  'Remind me about',
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryColor,
                    fontFamily: 'Schyler',
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return RemindDialog(
                          title: 'Remind me about?',
                          actions: [
                            const Row(
                              children: [],
                            ),
                            common.buildCustomButton(
                              context,
                              'Watering',
                              () {
                                setState(() {
                                  selectedAction = 'Watering';
                                });
                                Navigator.of(context).pop();
                              },
                              AppColors.backGroundColor,
                              AppColors.primaryColor,
                              const EdgeInsets.symmetric(horizontal: 30),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            common.buildCustomButton(
                              context,
                              'Fertilizing',
                              () {
                                setState(() {
                                  selectedAction = 'Fertilizing';
                                });
                                Navigator.of(context).pop();
                              },
                              AppColors.backGroundColor,
                              AppColors.primaryColor,
                              const EdgeInsets.symmetric(horizontal: 30),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            common.buildCustomButton(
                              context,
                              'Pruning',
                              () {
                                setState(() {
                                  selectedAction = 'Pruning';
                                });
                                Navigator.of(context).pop();
                              },
                              AppColors.backGroundColor,
                              AppColors.primaryColor,
                              const EdgeInsets.symmetric(horizontal: 30),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: selectedAction != null
                      ? Text(selectedAction!)
                      : const Icon(Icons.arrow_drop_down),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyListTile(
                leading: const Text(
                  'Frequency',
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryColor,
                    fontFamily: 'Schyler',
                  ),
                ),
                trailing: DropdownButton<String>(
                  value: selectedFrequency,
                  underline: Container(),
                  onChanged: (value) {
                    setState(() {
                      selectedFrequency = value!;
                    });
                  },
                  items: ['Daily', 'Weekly', 'Monthly'].map((frequency) {
                    return DropdownMenuItem<String>(
                      value: frequency,
                      child: Text(
                        frequency,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 15,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyListTile(
                leading: const Text(
                  'Start time',
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryColor,
                    fontFamily: 'Schyler',
                  ),
                ),
                trailing: IconButton(
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedStartDate = pickedDate;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              MyListTile(
                leading: const Text(
                  'Care notification',
                  style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryColor,
                    fontFamily: 'Schyler',
                  ),
                ),
                trailing: IconButton(
                  onPressed: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        selectedNotificationTime = pickedTime;
                      });
                    }
                  },
                  icon: const Icon(Icons.alarm_add),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              common.buildCustomButton(
                context,
                'Update',
                () {
                  if (selectedAction != null &&
                      selectedNotificationTime != null) {
                    final updatedValue = ReminderModel(
                      frequency: selectedFrequency,
                      id: widget.id,
                      plantName: widget.plants,
                      reminderName: selectedAction,
                      selectedNotificationTime:
                          selectedNotificationTime?.format(context),
                      selectedStartDate:
                          selectedStartDate?.timeZoneOffset.toString(),
                      imagePath: widget.imagePath,
                    );

                    ReminderDb.instance.updateReminders(updatedValue);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Reminder updated successfully'),
                      ),
                    );
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReminderList()),
                        (route) => false);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const ReminderList()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please edit the fields'),
                      ),
                    );
                  }
                },
                AppColors.primaryColor,
                AppColors.whiteForText,
                const EdgeInsets.symmetric(horizontal: 5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
