import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tesis/loginScreens/login.dart';
import 'package:tesis/settings_screen/fire_store.dart';
import 'package:tesis/settings_screen/setting_widgets/app_info.dart';
import 'package:tesis/settings_screen/setting_widgets/privacy_policy.dart';
import 'package:tesis/settings_screen/setting_widgets/terms_conditions.dart';
import 'package:tesis/settings_screen/setting_widgets/tips.dart';
import 'package:tesis/utilis/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 10,
        title: Row(
          children: [
            Image.asset(
              'assets/logo.png',
              height: 70,
              // width: 50,
              color: AppColors.primaryColor,
            ),
          ],
        ),
        backgroundColor: AppColors.backGroundColor,
        centerTitle: false,
      ),
      body: Container(
        color: AppColors.backGroundColor,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              userName,
              style: const TextStyle(
                letterSpacing: 1,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.blackForText,
                fontFamily: 'Schyler',
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              FirebaseAuth.instance.currentUser?.email ?? '',
              style: const TextStyle(
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryColor,
                fontFamily: 'Schyler',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              userPhone,
              style: const TextStyle(
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryColor,
                fontFamily: 'Schyler',
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(height: 5),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Edit Profile',
                style: TextStyle(
                  letterSpacing: 1,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: AppColors.blackForText,
                  fontFamily: 'Schyler',
                ),
              ),
            ),
            const Divider(),
            // ListTiles
            Column(
              children: [
                customListTile(
                    title: 'Tips',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TipsPage(),
                          ));
                    }),
                const SizedBox(
                  height: 10,
                ),
                customListTile(
                    title: 'App info',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlantInfoPage(),
                          ));
                    }),
                const SizedBox(
                  height: 10,
                ),
                customListTile(
                    title: 'Privacy and policy',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyPage(),
                          ));
                    }),
                const SizedBox(
                  height: 10,
                ),
                customListTile(
                    title: 'Terms and conditions',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const TermsAndConditionsPage(),
                          ));
                    }),
                const SizedBox(
                  height: 10,
                ),
                customListTile(
                    title: 'Sign out',
                    onPressed: () {
                      showLogoutDialog(context);
                    }),
              ],
            ),
            const SizedBox(height: 16.0),

            // TextButton(
            //   onPressed: () async {
            //     showLogoutDialog(context);
            //   },
            //   child: const Text(
            //     'Sign Out',
            //     style: TextStyle(
            //       letterSpacing: 1,
            //       fontSize: 20,
            //       fontWeight: FontWeight.w900,
            //       color: AppColors.blackForText,
            //       fontFamily: 'Schyler',
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget customListTile({
    IconData? leadingIcon,
    required String title,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 10,
      child: ListTile(
        leading: Icon(leadingIcon),
        title: Text(
          title,
          style: const TextStyle(
            letterSpacing: 1,
            fontSize: 15,
            fontWeight: FontWeight.w900,
            color: AppColors.blackForText,
            fontFamily: 'Schyler',
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_drop_down),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
