import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:tesis/loginScreens/common_widgets.dart';
import 'package:tesis/reminders_screen/alert_dialogue.dart';
import 'package:tesis/reminders_screen/listtile_reminders.dart';
import 'package:tesis/reminders_screen/reminder_db_functions/reminder_db_functions.dart';
import 'package:tesis/reminders_screen/reminder_models/reminder_model.dart';
import 'package:tesis/reminders_screen/reminders_list.dart';
import 'package:tesis/utilis/app_colors.dart';

class Reminders extends StatefulWidget {
  final String? plant;
  final String? imagePath;

  const Reminders({Key? key, required this.plant, this.imagePath})
      : super(key: key);

  @override
  State<Reminders> createState() => _RemindersState();
}

class _RemindersState extends State<Reminders> {
  final CommonWidgets common = CommonWidgets();

  DateTime? _selectedStartDate;
  TimeOfDay? _selectedNotificationTime;
  String? selectedAction;
  String selectedFrequency = 'Daily';

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
              firstText: 'set ',
              firstTextStyle: const TextStyle(
                  letterSpacing: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryColor,
                  fontFamily: 'Schyler'),
              secondText: 'reminder',
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
          child: SingleChildScrollView(
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
                        fontFamily: 'Schyler'),
                  ),
                  trailing: Text(
                    widget.plant.toString(),
                    style: const TextStyle(
                        fontSize: 18,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryColor,
                        fontFamily: 'Schyler'),
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
                        fontFamily: 'Schyler'),
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
                                'Fertlizing',
                                () {
                                  setState(() {
                                    selectedAction = 'Fertlizing';
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
                              common.buildCustomButton(context, 'Pruning', () {
                                setState(() {
                                  selectedAction = 'Pruning';
                                });
                                Navigator.of(context).pop();
                              },
                                  AppColors.backGroundColor,
                                  AppColors.primaryColor,
                                  const EdgeInsets.symmetric(horizontal: 30))
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
                      color: AppColors.primaryColor, // AppColors.primaryColor,
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
                        fontFamily: 'Schyler'),
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
                          _selectedStartDate = pickedDate;
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
                        fontFamily: 'Schyler'),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          _selectedNotificationTime = pickedTime;
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
                  'save',
                  () {
                    // DateTime targetTime =
                    //     DateTime.now().add(const Duration(minutes: 1));
                    // int min = targetTime.minute;
                    // int notificationId = 1;

                    // AwesomeNotifications().createNotification(
                    //   content: NotificationContent(
                    //     id: notificationId,
                    //     channelKey: 'basic_channel',
                    //     title: 'Plant Care Reminder!',
                    //     body:
                    //         'Remember to $selectedAction your ${widget.plant}',
                    //   ),
                    //   schedule: NotificationCalendar(
                    //     minute: min,
                    //   ),
                    // );
                    if (_selectedNotificationTime != null &&
                        _selectedStartDate != null) {
                      // Construct the scheduled time using user-provided date and time
                      final scheduledTime = DateTime(
                        _selectedStartDate!.year,
                        _selectedStartDate!.month,
                        _selectedStartDate!.day,
                        _selectedNotificationTime!.hour,
                        _selectedNotificationTime!.minute,
                      );

                      // Generate a unique notification ID to avoid conflicts
                      const notificationId = 1;

                      AwesomeNotifications().createNotification(
                        content: NotificationContent(
                          id: notificationId,
                          channelKey: 'basic_channel',
                          title: 'Plant Care Reminder!',
                          body:
                              'Remember to $selectedAction your ${widget.plant}',
                        ),
                        schedule: NotificationCalendar(
                          // Set the scheduled minute to the minute of the scheduled time
                          minute: scheduledTime.minute,
                          // Set the scheduled hour to the hour of the scheduled time
                          hour: scheduledTime.hour,
                          // Set the scheduled day to the day of the scheduled time
                          day: scheduledTime.day,
                          // Set the scheduled month to the month of the scheduled time
                          month: scheduledTime.month,
                          // Set the scheduled year to the year of the scheduled time
                          year: scheduledTime.year,
                        ),
                      );
                    }

                    if (_selectedStartDate == null ||
                        _selectedNotificationTime == null ||
                        selectedAction == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please select the fields'),
                      ));
                    } else {
                      final reminderValue = ReminderModel(
                        frequency: selectedFrequency,
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                        plantName: widget.plant,
                        reminderName: selectedAction,
                        selectedNotificationTime:
                            _selectedNotificationTime?.format(context),
                        selectedStartDate: _selectedStartDate?.toString(),
                        imagePath: widget.imagePath,
                      );

                      ReminderDb.instance.addReminder(reminderValue);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReminderList(
                            imagepath: widget.imagePath,
                          ),
                        ),
                      );
                    }
                  },
                  AppColors.primaryColor,
                  AppColors.whiteForText,
                  const EdgeInsets.symmetric(horizontal: 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
