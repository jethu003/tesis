import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: const SingleChildScrollView( // Allow scrolling for long terms
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Agreement',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'These Terms and Conditions ("Terms") constitute a legally binding agreement between you ("User") and [Your App Name] ("App"), owned and operated by [Your Company Name] ("Company").',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Use of the App',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'By accessing or using the App, you agree to be bound by these Terms. If you disagree with any part of these Terms, you may not access or use the App.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Intellectual Property',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'The App and all its content, including but not limited to text, graphics, logos, images, and software, are the property of the Company and are protected by copyright and other intellectual property laws.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Disclaimer',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'The App is provided "as is" and without warranties of any kind, whether express or implied. The Company disclaims all warranties, including but not limited to, the implied warranties of merchantability, fitness for a particular purpose, and non-infringement.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            // Add more sections as needed (Limitation of Liability, Termination, etc.)
          ],
        ),
      ),
    );
  }
}
