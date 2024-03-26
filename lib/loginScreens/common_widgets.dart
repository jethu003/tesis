import 'package:flutter/material.dart';
import 'package:tesis/settings_screen/setting_screen.dart';
import 'package:tesis/utilis/app_colors.dart';
// import 'package:image_picker/image_picker.dart';

class CommonWidgets {
  // for register and login screen
  Widget buildWelcomeText() {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: RichText(
        textAlign: TextAlign.left,
        text: const TextSpan(
          style: TextStyle(
            fontSize: 24.0,
            color: AppColors.blackForText,
          ),
          children: [
            TextSpan(
              text: 'Welcome \n',
              style: TextStyle(
                letterSpacing: 3,
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 245, 246, 247),
                fontFamily: 'YourFirstFont',
              ),
            ),
            TextSpan(
              text: 'to',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                fontSize: 28,
                color: Color.fromARGB(255, 239, 244, 241),
                fontFamily: 'YourSecondFont',
              ),
            ),
            TextSpan(
              text: '  teSis',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 32,
                color: Color.fromARGB(255, 1, 17, 6),
                fontFamily: 'YourSecondFont',
              ),
            ),
          ],
        ),
      ),
    );
  }

// customButton widgets
  Widget buildCustomButton(
    BuildContext context,
    String buttonText,
    VoidCallback onPressed,
    Color buttonColor,
    Color textColor,
    EdgeInsetsGeometry padding,
  ) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          fixedSize: MaterialStateProperty.all<Size>(
            const Size(315.0, 55.0),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(08.0),
              side: BorderSide(
                color: textColor,
                width: 0,
              ),
            ),
          ),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }

// descriotion

  Widget buildDescriptionText(String text, EdgeInsetsGeometry padding) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        style: const TextStyle(
          letterSpacing: 2,
          fontSize: 15,
          color: AppColors.blackForText,
        ),
      ),
    );
  }

  // for register screen

  Widget buildRichText({
    required String firstText,
    required TextStyle firstTextStyle,
    required String secondText,
    required TextStyle secondTextStyle,
  }) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: firstText,
            style: firstTextStyle,
          ),
          TextSpan(
            text: secondText,
            style: secondTextStyle,
          ),
        ],
      ),
    );
  }

// textfield

  Widget buildCustomTextFormField({
    required TextEditingController controller,
    required IconData prefixIcon,
    required String hintText,
    required Function(String?)? validator,
    bool obscureText = false, // Default value is false
  }) {
    return TextFormField(
      style: const TextStyle(
        fontWeight: FontWeight.normal,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: (value) {
        if (validator != null) {
          return validator(value);
        }
        return null;
      },
      obscureText: obscureText, // Set obscureText to true for password field
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          size: 18,
          color: Colors.green,
        ),
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
        border: InputBorder.none,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.green),
        ),
        errorBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(vertical: 13.0),
      ),
    );
  }

  Widget settingButton(BuildContext context) {
    return IconButton(
      color: AppColors.primaryColor,
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 30, vertical: 10),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingsScreen(),
          ),
        );
      },
      icon: const Icon(
        Icons.settings,
        color: AppColors.primaryColor,
        size: 28,
      ),
    );
  }
}
