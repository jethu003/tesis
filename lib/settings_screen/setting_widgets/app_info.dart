import 'package:flutter/material.dart';
import 'package:tesis/loginScreens/common_widgets.dart';
import 'package:tesis/utilis/app_colors.dart';
import 'package:tesis/utilis/text_style.dart';

class PlantInfoPage extends StatelessWidget {
  PlantInfoPage({super.key});
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
              firstText: 'App ',
              firstTextStyle: const TextStyle(
                  letterSpacing: 2,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryColor,
                  fontFamily: 'Schyler'),
              secondText: 'info',
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
        child: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextStyle(
                    text:
                        'Welcome to Tesis, your go-to app for all things plants! Whether you\'re a seasoned gardener or just getting started with your indoor jungle, Tesis is here to help you nurture and grow your green friends. With  personalized care tips, and interactive features, Tesis makes plant care easy, enjoyable, and rewarding.',
                  ),
                  SizedBox(height: 20.0),
                  Divider(),
                  CustomTextStyle(
                    text: 'Key Features:',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  ListTile(
                      leading: Icon(Icons.check),
                      title: CustomTextStyle(
                        text: 'Personolized Care Tips',
                        fontSize: 16,
                      ),
                      subtitle: CustomTextStyle(
                        text:
                            'Receive customized care tips based on your location and individual plant collection.',
                        fontSize: 13,
                      )),
                  ListTile(
                    leading: Icon(Icons.check),
                    title: CustomTextStyle(
                      text: 'Wishlist & Collection',
                    ),
                    subtitle: CustomTextStyle(
                      text: 'Keep track of plants you own or wish to acquire.',
                      fontSize: 13,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.check),
                    title: CustomTextStyle(
                      text: 'News & Updates',
                    ),
                    subtitle: CustomTextStyle(
                      text:
                          'Stay informed about the latest trends and news in the world of plants.',
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  CustomTextStyle(
                    text: 'Why Choose Tesis?',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextStyle(
                    text:
                        '- Easy-to-use interface for plant enthusiasts of all levels\n'
                        '- Reliable plant care information backed by experts\n'
                        '- Interactive features for a fun and engaging plant care experience\n'
                        '- Regular updates and new features to enhance your gardening journey',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
