import 'package:flutter/material.dart';
import 'package:tesis/forUser/my_garden.dart';
import 'package:tesis/forUser/my_plants_task.dart';
import 'package:tesis/home_screens/home_screen.dart';
import 'package:tesis/reminders_screen/reminders_list.dart';
import 'package:tesis/utilis/app_colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Widget> pages = [
    const HomeScreen(),
    const MyPlantsTask(),
    const ReminderList(),
    const MyPlants(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: AppColors.appbarColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: AppColors.primaryColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_task,
              color: AppColors.primaryColor,
            ),
            label: 'Plants',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.task_alt_outlined,
              color: AppColors.primaryColor,
            ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.yard,
              color: AppColors.primaryColor,
            ),
            label: 'Yard',
          ),
        ],
      ),
    );
  }
}
