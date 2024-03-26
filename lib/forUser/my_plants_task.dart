import 'package:flutter/material.dart';
import 'package:tesis/forUser/add_plants.dart';
import 'package:tesis/forUser/description.dart';
import 'package:tesis/forUser/listtyle_refracterd.dart';
import 'package:tesis/forUser/refractored_user/bottom_sheet.dart';
import 'package:tesis/forUser/refractored_user/edit_plants.dart';
import 'package:tesis/hive_db_functions/db_functions/hive_addplants.dart';
import 'package:tesis/hive_db_functions/hive_models/add_plants.dart';
import 'package:tesis/loginScreens/common_widgets.dart';
import 'package:tesis/reminders_screen/set_reminder.dart';
import 'package:tesis/utilis/app_colors.dart';

class MyPlantsTask extends StatefulWidget {
  const MyPlantsTask({Key? key}) : super(key: key);

  @override
  State<MyPlantsTask> createState() => _MyPlantsTaskState();
}

class _MyPlantsTaskState extends State<MyPlantsTask> {
  final CommonWidgets common = CommonWidgets();

  @override
  void initState() {
    AddPlantsDb.instance.reFreshdata();
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
              firstText: 'add ',
              firstTextStyle: const TextStyle(
                letterSpacing: 2,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryColor,
                fontFamily: 'Schyler',
              ),
              secondText: 'plants',
              secondTextStyle: const TextStyle(
                  letterSpacing: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryColor,
                  fontFamily: 'Schyler'),
            ),
          ],
        ),
        actions: [
          common.settingButton(context),
        ],
        backgroundColor: AppColors.backGroundColor,
        centerTitle: false,
      ),
      floatingActionButton: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPlants(),
              ),
            );
          },
          icon: const Icon(Icons.add_a_photo)),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        color: const Color.fromARGB(255, 240, 251, 240),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: AddPlantsDb.instance.userAddedplants,
                builder: (BuildContext context, List<AddPlantModel> valueList,
                    Widget? _) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final data = valueList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DescriptionScreen(
                                backgroundImage: data.imagePath.toString(),
                                name: data.name.toString(),
                                description: data.description.toString());
                          }));
                        },
                        child: CustomCard(
                          imagepath: data.imagePath.toString(),
                          title: data.name.toString(),
                          subtitle: data.location.toString(),
                          trailing: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return buildButtonContainer(
                                    reminderText: 'add Reminders',
                                    onPressedEdit: () async {
                                      Navigator.of(context).pop();
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return EditPlantDetails(
                                            imagePath:
                                                data.imagePath.toString(),
                                            id: data.id.toString(),
                                            intialLocation:
                                                data.location.toString(),
                                            initialDescription:
                                                data.description.toString(),
                                            initialName: data.name.toString(),
                                          );
                                        },
                                      );
                                    },
                                    onPressedAddReminders: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return Reminders(
                                              plant: data.name.toString(),
                                              imagePath: data.imagePath,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    onPressedDelete: () {
                                      Navigator.of(context).pop();
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Delete Item"),
                                            content: const Text(
                                                "Are you sure you want to delete this?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  AddPlantsDb.instance
                                                      .deletePlantDetais(
                                                          data.id.toString());
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Delete"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.more_vert),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(color: Colors.grey[300], thickness: 1.0);
                    },
                    itemCount: valueList.length,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
