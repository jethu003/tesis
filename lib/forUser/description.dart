import 'dart:io';

import 'package:flutter/material.dart';

import 'package:tesis/forUser/show_experts.dart';
import 'package:tesis/loginScreens/common_widgets.dart';
import 'package:tesis/utilis/app_colors.dart';

class DescriptionScreen extends StatefulWidget {
  final String backgroundImage;
  final String name;
  final String description;

  const DescriptionScreen({
    Key? key,
    required this.backgroundImage,
    required this.name,
    required this.description,
  }) : super(key: key);

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  final CommonWidgets common = CommonWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 10,
        title: Row(
          children: [
            common.buildRichText(
              firstText: 'Description ',
              firstTextStyle: const TextStyle(
                letterSpacing: 2,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryColor,
                fontFamily: 'Schyler',
              ),
              secondText: '',
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
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        color: AppColors.backGroundColor,
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 40,
              child: Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: FileImage(
                      File(
                        widget.backgroundImage.toString(),
                      ),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.whiteForText),
              child: ListView(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                            letterSpacing: 1,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppColors.blackForText,
                            fontFamily: 'Schyler',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.description,
                        style: const TextStyle(
                          letterSpacing: 1,
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: AppColors.blackForText,
                          fontFamily: 'Schyler',
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            common.buildCustomButton(
              context,
              'Book an Expert ?',
              () {
                print('button clicked');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExpertsListPage(),
                  ),
                );
              },
              AppColors.primaryColor,
              AppColors.whiteForText,
              const EdgeInsets.symmetric(horizontal: 20),
            )
          ],
        ),
      ),
    );
  }
}
