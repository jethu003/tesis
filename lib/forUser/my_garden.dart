import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tesis/hive_db_functions/db_functions/hive_addplants.dart';
import 'package:tesis/hive_db_functions/hive_models/add_plants.dart';
import 'package:tesis/loginScreens/common_widgets.dart';
import 'package:tesis/utilis/app_colors.dart';

class MyPlants extends StatefulWidget {
  const MyPlants({Key? key}) : super(key: key);

  @override
  State<MyPlants> createState() => _MyPlantsState();
}

class _MyPlantsState extends State<MyPlants> {
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
        leading: IconButton(
          icon:const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context); // This pops the current route off the navigation stack
          },
        ),
        elevation: 10,
        title: Row(
          children: [
            common.buildRichText(
              firstText: 'your ',
              firstTextStyle: const TextStyle(
                  letterSpacing: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryColor,
                  fontFamily: 'Schyler'),
              secondText: 'plants',
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
        color: const Color.fromARGB(255, 240, 251, 240),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: AddPlantsDb.instance.userAddedplants,
                  builder: (BuildContext ctx, List<AddPlantModel> valueList,
                      Widget? _) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            2, // You can adjust the cross axis count as needed
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: valueList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 20,
                          shadowColor: const Color.fromARGB(255, 214, 131, 42),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: FileImage(File(
                                    valueList[index].imagePath.toString())),
                                fit: BoxFit.cover, // Adjust the fit as needed
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
