import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView( // Allow scrolling for long policies
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Introduction',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'This Privacy Policy describes how [Your App Name] (the "App") collects, uses, and discloses your information.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Information We Collect',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'We may collect the following information from you:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 5.0),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Device information (e.g., device model, operating system)'),
            ),
            SizedBox(height: 5.0),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search queries within the app'),
            ),
            SizedBox(height: 10.0),
            Text(
              'Use of Information',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'We may use your information to:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 5.0),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Improve the app and user experience'),
            ),
            SizedBox(height: 5.0),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Send you personalized notifications (optional, with user consent)'),
            ),
            SizedBox(height: 10.0),
            Text(
              'Your Choices',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'You have choices regarding your information:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 5.0),
            ListTile(
              leading: Icon(Icons.remove_circle),
              title: Text('Opt-out of receiving notifications'),
            ),
            SizedBox(height: 10.0),
            // Add more sections as needed (Data Sharing, Changes to Policy, etc.)
          ],
        ),
      ),
    );
  }
}
