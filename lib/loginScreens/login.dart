import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tesis/admin_panel/admin_home.dart';
import 'package:tesis/home_screens/bottom_navigator.dart';
import 'package:tesis/loginScreens/common_widgets.dart';
import 'package:tesis/loginScreens/register.dart';
import 'package:tesis/settings_screen/fire_store.dart';
import 'package:tesis/utilis/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final CommonWidgets common = CommonWidgets();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 240, 251, 240),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(42, 0, 40, 0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                common.buildRichText(
                  firstText: 'Login to ',
                  firstTextStyle: const TextStyle(
                    letterSpacing: 3,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: AppColors.blackForText,
                  ),
                  secondText: 'teSis',
                  secondTextStyle: const TextStyle(
                    letterSpacing: 3,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: AppColors.greenForText,
                  ),
                ),
                const SizedBox(height: 20),
                common.buildDescriptionText(
                  'Feel fresh with plants world.',
                  const EdgeInsets.fromLTRB(0, 0, 0, 0),
                ),
                common.buildDescriptionText(
                  'It will enhance your living space!',
                  const EdgeInsets.fromLTRB(0, 0, 0, 0),
                ),
                const SizedBox(height: 20),
                common.buildCustomTextFormField(
                  controller: emailController,
                  prefixIcon: Icons.email,
                  hintText: 'email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                common.buildCustomTextFormField(
                  obscureText: true,
                  controller: passwordController,
                  prefixIcon: Icons.password,
                  hintText: 'password',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                common.buildCustomButton(
                  context,
                  'LOGIN',
                  signInUser,
                  AppColors.greenForText,
                  AppColors.whiteForText,
                  const EdgeInsets.fromLTRB(0, 0, 0, 0),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    const Text('Dont have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: AppColors.greenForText),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInUser() async {
    FirestroreService().getUsers();

    if (_formKey.currentState!.validate()) {
      try {
        // Sign in with email and password
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // Check if the user is an admin
        if (emailController.text == 'flutter@gmail.com' &&
            passwordController.text == '12345678') {
          // Navigate to the admin page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AdminHome(),
            ),
          );
        } else {
          // Navigate to the regular user home page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        // Handle error and show SnackBar with an appropriate message
        String errorMessage = '';
        switch (e.code) {
          case 'invalid-email':
            errorMessage = 'The email address is invalid.';
            break;
          // Add more cases for other potential errors
          default:
            errorMessage = 'enter valid email id and password!';
        }

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
