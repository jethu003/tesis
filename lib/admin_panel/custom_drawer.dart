import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tesis/admin_panel/add_experts.dart';
import 'package:tesis/admin_panel/add_herbs.dart';
import 'package:tesis/admin_panel/add_recomendations.dart';
import 'package:tesis/admin_panel/admin_booking.dart';
import 'package:tesis/admin_panel/admin_home.dart';
import 'package:tesis/admin_panel/delete_experts.dart';
import 'package:tesis/loginScreens/login.dart';
import 'package:tesis/utilis/app_colors.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backGroundColor,
      width: 275,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Container(
          color: AppColors.backGroundColor,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.home, color: AppColors.primaryColor),
                title: const Text('Admin Home',
                    style: TextStyle(color: AppColors.primaryColor)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminHome(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_forward,
                    color: AppColors.primaryColor),
                title: const Text('Add Herbs',
                    style: TextStyle(color: AppColors.primaryColor)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HerbsPage(),
                    ),
                  ); // Navigate to profile screen
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_forward,
                    color: AppColors.primaryColor),
                title: const Text(
                  'Add UserRecomentation',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RecommendationsPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.arrow_forward,
                    color: AppColors.primaryColor),
                title: const Text(
                  'Add Experts',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddExperts(),
                    ),
                  );
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.logout, color: AppColors.primaryColor),
                title: const Text('Delete Expert',
                    style: TextStyle(color: AppColors.primaryColor)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeleteExpert(),
                    ),
                  );
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.logout, color: AppColors.primaryColor),
                title: const Text('Bookin Status',
                    style: TextStyle(color: AppColors.primaryColor)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingListAdmin (),
                    ),
                  );
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.logout, color: AppColors.primaryColor),
                title: const Text('Logout',
                    style: TextStyle(color: AppColors.primaryColor)),
                onTap: () {
                  // Navigate to settings screen
                  showLogoutDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> showLogoutDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false, // Predicate that removes all routes
              );
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  );
}
