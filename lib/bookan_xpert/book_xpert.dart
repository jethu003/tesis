import 'package:flutter/material.dart';
import 'package:tesis/admin_panel/booking_list.dart';
import 'package:tesis/loginScreens/common_widgets.dart';
import 'package:tesis/reminders_screen/listtile_reminders.dart';
import 'package:tesis/utilis/app_colors.dart';

class BookExpertScreen extends StatefulWidget {
  const BookExpertScreen({super.key});

  @override
  BookExpertScreenState createState() => BookExpertScreenState();
}

class BookExpertScreenState extends State<BookExpertScreen> {
  final CommonWidgets common = CommonWidgets();

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
              firstText: 'Book',
              firstTextStyle: const TextStyle(
                  letterSpacing: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryColor,
                  fontFamily: 'Schyler'),
              secondText: 'an Expert',
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
                const MyListTile(
                  leading: Text(
                    'Book an Expert',
                    style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryColor,
                        fontFamily: 'Schyler'),
                  ),
                  trailing: Text(
                    'hello',
                    style: TextStyle(
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
                    'Date',
                    style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryColor,
                        fontFamily: 'Schyler'),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_month),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyListTile(
                  leading: const Text(
                    'Time',
                    style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryColor,
                        fontFamily: 'Schyler'),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.alarm_add),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                common.buildCustomButton(
                  context,
                  'Book an Expert',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingListPage(),
                      ),
                    );
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
