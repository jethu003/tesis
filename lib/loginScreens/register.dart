import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tesis/home_screens/bottom_navigator.dart';
import 'package:tesis/loginScreens/common_widgets.dart';
import 'package:tesis/loginScreens/login.dart';
import 'package:tesis/utilis/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final CommonWidgets common = CommonWidgets();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 240, 251, 240),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(42, 200, 40, 0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  common.buildRichText(
                    firstText: 'Register on ',
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
                  const SizedBox(height: 15),
                  common.buildDescriptionText(
                    'Create a teSis account we cant ',
                    const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  ),
                  common.buildDescriptionText(
                    'wait to have you',
                    const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  ),
                  const SizedBox(height: 15),
                  common.buildCustomTextFormField(
                    controller: nameController,
                    prefixIcon: Icons.person,
                    hintText: 'name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Incorrect name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  common.buildCustomTextFormField(
                      controller: emailController,
                      prefixIcon: Icons.email,
                      hintText: 'email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 5,
                  ),
                  common.buildCustomTextFormField(
                    controller: phoneController,
                    prefixIcon: Icons.phone,
                    hintText: 'phone',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Incorrect ph number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
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
                  const SizedBox(
                    height: 20,
                  ),
                  common.buildCustomButton(
                    context,
                    'REGISTER',
                    registeruser,
                    AppColors.greenForText,
                    AppColors.whiteForText,
                    const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  ),
                  Row(
                    children: [
                      const Text('Already a user ?'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Log in',
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
      ),
    );
  }

  Future<void> addUserDetailsToFirestore(
      String name, String email, String phone) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      // Add user details to Firestore
      await FirebaseFirestore.instance.collection('users').doc(email).set({
        'name': name,
        'email': email,
        'phone': phone,
        'uid': uid,
        
        // Add other details as needed
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> registeruser() async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        addUserDetailsToFirestore(
            nameController.text, emailController.text, phoneController.text);

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(),
            ));
      } on FirebaseAuthException catch (e) {
        // Handle error and show SnackBar with an appropriate snackbar
        String errorMessage = '';
        switch (e.code) {
          case 'weak-password':
            errorMessage = 'The password provided is too weak.';
            break;
          case 'email-already-in-use':
            errorMessage =
                'The email address is already in use by another account.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is invalid.';
            break;
          default:
            errorMessage = 'Invalid credentials';
        }

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            // ignore: use_build_context_synchronously
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
