import 'package:flutter/material.dart';
import 'package:tesis/loginScreens/common_widgets.dart';
import 'package:tesis/loginScreens/login.dart';
import 'package:tesis/loginScreens/register.dart';
import 'package:tesis/utilis/app_colors.dart';

class RegisterLogin extends StatelessWidget {
  RegisterLogin({Key? key}) : super(key: key);
  final CommonWidgets common = CommonWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/plants.jpg'),
            ),
          ),
          child: Container(
            alignment: Alignment.centerLeft,
            color: const Color.fromARGB(255, 90, 137, 92).withOpacity(0.6),
            padding: const EdgeInsets.fromLTRB(38, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                common.buildWelcomeText(),
                const SizedBox(height: 30),
                common.buildDescriptionText(
                  'Feel fresh with plants world.',
                  const EdgeInsets.fromLTRB(0, 0, 0, 0),
                ),
                common.buildDescriptionText(
                  'It will enhance your living space!',
                  const EdgeInsets.fromLTRB(0, 0, 0, 0),
                ),
                const SizedBox(height: 20),
                common.buildCustomButton(
                  context,
                  'REGISTER',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  Colors.transparent,
                  AppColors.whiteForText,
                  const EdgeInsets.fromLTRB(0, 0, 0, 0),
                ),
                const SizedBox(height: 15),
                common.buildCustomButton(
                  context,
                  'LOGIN',
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  AppColors.whiteForText,
                  AppColors.blackForText,
                  const EdgeInsets.fromLTRB(0, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
