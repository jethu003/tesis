import 'package:flutter/material.dart';
import 'package:tesis/loginScreens/common_widgets.dart';
import 'package:tesis/utilis/app_colors.dart';
import 'package:tesis/utilis/text_style.dart';

class TipsPage extends StatelessWidget {
  TipsPage({
    super.key,
  });
  final CommonWidgets common = CommonWidgets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context); // This pops the current route off the navigation stack
          },
        ),
        elevation: 10,
        title: Row(
          children: [
            common.buildRichText(
              firstText: 'Tips',
              firstTextStyle: const TextStyle(
                  letterSpacing: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryColor,
                  fontFamily: 'Schyler'),
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
        backgroundColor: AppColors.backGroundColor,
        centerTitle: false,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextStyle(
              text: 'Tips for Healthy Plants',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 10),
            CustomTextStyle(
              text:
                  '1. Provide proper sunlight according to plant requirements.',
              fontSize: 16,
            ),
            CustomTextStyle(
              text: '2. Water plants regularly, but avoid overwatering.',
              fontSize: 16,
            ),
            CustomTextStyle(
              text: '3. Use well-draining soil for potted plants.',
              fontSize: 16,
            ),
            CustomTextStyle(
              text:
                  '4. Prune dead or damaged leaves regularly to promote new growth.',
              fontSize: 16,
            ),
            CustomTextStyle(
              text:
                  '5. Monitor for pests and diseases and take appropriate action if detected.',
              fontSize: 16,
            ),
          ],
        ),
      ),
    );
  }
}
