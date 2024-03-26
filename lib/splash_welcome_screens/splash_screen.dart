// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tesis/admin_panel/admin_home.dart';
import 'package:tesis/home_screens/bottom_navigator.dart';
import 'package:tesis/loginScreens/register_login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateNext();
  }

  navigateNext() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User is logged in
      if (user.email == 'flutter@gmail.com') {
        // Admin is logged in, navigate to AdminHome
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminHome()),
        );
      } else {
        // Regular user is logged in, navigate to MyHomePage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      }
    } else {
      // No user logged in, navigate to LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegisterLogin()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/splash.jpg',
              ),
            ),
          ),
          child: Container(
            color: const Color.fromARGB(255, 90, 137, 92).withOpacity(0.6),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/tesis_logo.png'),
                  height: 250,
                  width: 250,
                ),
              ],
            ),
          )),
    );
  }
}
