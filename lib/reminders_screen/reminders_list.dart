import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tesis/forUser/add_plants.dart';
import 'package:tesis/forUser/refractored_user/bottom_sheet.dart';
import 'package:tesis/loginScreens/common_widgets.dart';
import 'package:tesis/reminders_screen/edit_reminders.dart';
import 'package:tesis/reminders_screen/reminder_db_functions/reminder_db_functions.dart';
import 'package:tesis/utilis/app_colors.dart';

class ReminderList extends StatefulWidget {
  final String? imagepath;
  const ReminderList({
    super.key,
    this.imagepath,
  });

  @override
  State<ReminderList> createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  final CommonWidgets common = CommonWidgets();
  @override
  void initState() {
    ReminderDb.instance.refreshReminders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 10,
        title: Row(
          children: [
            common.buildRichText(
              firstText: 'Your ',
              firstTextStyle: const TextStyle(
                  letterSpacing: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryColor,
                  fontFamily: 'Schyler'),
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
        actions: [
          common.settingButton(context),
        ],
        backgroundColor: AppColors.backGroundColor,
        centerTitle: false,
      ),
      body: Container(
        color: AppColors.backGroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Divider(
              thickness: 5,
              color: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Reminders',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  letterSpacing: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryColor,
                  fontFamily: 'Schyler',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              // Wrap the ListView.builder with Expanded widget
              child: Card(
                elevation: 20,
                child: ValueListenableBuilder(
                  valueListenable: ReminderDb.instance.userAddedReminders,
                  builder: (context, value, child) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        final reminderData = value[index];

                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                // Display the image if available
                                if (reminderData.imagePath != null &&
                                    reminderData.imagePath!.isNotEmpty)
                                  CircleAvatar(
                                    backgroundImage: FileImage(
                                      File(
                                        reminderData.imagePath.toString(),
                                      ),
                                    ),
                                  )
                                else
                                  const CircleAvatar(
                                    child: Icon(Icons.image),
                                  ),
                                const SizedBox(width: 12.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        reminderData.plantName.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        'Frequency: ${reminderData.frequency.toString()}',
                                        style: const TextStyle(fontSize: 12.0),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        'Notification Time: ${reminderData.selectedNotificationTime.toString()}',
                                        style: const TextStyle(fontSize: 12.0),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        'Started date : ${reminderData.selectedStartDate.toString()}',
                                        style: const TextStyle(fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return buildButtonContainer(
                                                reminderText: 'Add plants',
                                                onPressedEdit: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditReminders(
                                                        id: reminderData.id
                                                            .toString(),
                                                        selectedAction:
                                                            reminderData
                                                                .reminderName
                                                                .toString(),
                                                        selectedDate: reminderData
                                                            .selectedStartDate
                                                            .toString(),
                                                        selectedFrequency:
                                                            reminderData
                                                                .frequency
                                                                .toString(),
                                                        selectedNotification:
                                                            reminderData
                                                                .selectedNotificationTime
                                                                .toString(),
                                                        imagePath: reminderData
                                                            .imagePath
                                                            .toString(),
                                                        plants: reminderData
                                                            .plantName
                                                            .toString(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                onPressedAddReminders: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AddPlants()));
                                                },
                                                onPressedDelete: () {
                                                  Navigator.of(context).pop();
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            "Delete Item"),
                                                        content: const Text(
                                                            "Are you sure you want to delete this?"),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                "Cancel"),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              ReminderDb
                                                                  .instance
                                                                  .deleteReminders(
                                                                      reminderData
                                                                          .id
                                                                          .toString());
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                "Delete"),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                });
                                          });
                                    },
                                    icon: const Icon(Icons.more_vert))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
