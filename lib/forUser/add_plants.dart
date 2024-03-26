import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tesis/hive_db_functions/db_functions/hive_addplants.dart';
import 'package:tesis/hive_db_functions/hive_models/add_plants.dart';
import 'package:tesis/loginScreens/common_widgets.dart';
import 'package:tesis/utilis/app_colors.dart';

class AddPlants extends StatefulWidget {
  const AddPlants({super.key});

  @override
  State<AddPlants> createState() => _AddPlantsState();
}

class _AddPlantsState extends State<AddPlants> {
  final CommonWidgets common = CommonWidgets();
  // final Users userneeds = Users();
  final TextEditingController plantName = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController details = TextEditingController();

  File? imageFile;

  // Function to open image picker
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
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
        actions: [
          common.settingButton(context),
        ],
        backgroundColor: AppColors.backGroundColor,
        centerTitle: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        color: const Color.fromARGB(255, 240, 251, 240),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: GestureDetector(
                      onTap: () {
                        _pickImage(ImageSource.gallery); // Open gallery
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            imageFile != null ? FileImage(imageFile!) : null,
                        child: imageFile == null
                            ? const Icon(
                                Icons.camera,
                                size: 50,
                                color: Colors.white,
                              )
                            : null,
                      )),
                ),
                const SizedBox(
                  height: 25,
                ),
                common.buildCustomTextFormField(
                  controller: plantName,
                  prefixIcon: Icons.abc,
                  hintText: 'name your plant',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please add name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                common.buildCustomTextFormField(
                  controller: location,
                  prefixIcon: Icons.abc,
                  hintText: 'add Location',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'add location';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                common.buildCustomTextFormField(
                  controller: details,
                  prefixIcon: Icons.abc,
                  hintText: 'add details',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'add detais';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                common.buildCustomButton(context, 'add', () {
                  if (plantName.text.isEmpty ||
                      details.text.isEmpty ||
                      imageFile == null) {
                    print('Error: Please enter all plant details');
                  } else {
                    final addDetails = AddPlantModel(
                      id: DateTime.now().microsecondsSinceEpoch.toString(),
                      location: location.text,
                      name: plantName.text,
                      imagePath: imageFile!.path.toString(),
                      description: details.text,
                    );

                    // Add the details to the databases
                    AddPlantsDb.instance.insertPlants(addDetails);
                    // AddPlantsDb().getPlants().then((value) {
                    //   print('hello');
                    //   print(value);
                    // });
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => const MyPlantsTask(),
                    //   ),
                    // );
                    Navigator.pop(context);

                    print('Data added: $addDetails');
                  }
                }, AppColors.primaryColor, AppColors.whiteForText,
                    const EdgeInsets.symmetric(horizontal: 30))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
