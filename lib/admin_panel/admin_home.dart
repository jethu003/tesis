import 'package:flutter/material.dart';

import 'package:tesis/admin_panel/custom_drawer.dart';
import 'package:tesis/utilis/app_colors.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  // Future<String?> uploadImageToFirebase() async {
  //   try {
  //     final pickedFile =
  //         await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (pickedFile == null) return null; // No image picked

  //     final file = File(pickedFile.path);

  //     final fileName =
  //         '${DateTime.now().microsecondsSinceEpoch}-${pickedFile.path.split('/').last}';
  //     final Reference ref =
  //         FirebaseStorage.instance.ref().child('uploads/$fileName');

  //     final TaskSnapshot uploadTask = await ref.putFile(file);
  //     final imageUrl = await uploadTask.ref.getDownloadURL();

  //     return imageUrl;
  //   } catch (e) {
  //     print('Error uploading image: $e');
  //     return null;
  //   }
  // }

  // Future<void> uploadDataToFirestore(String imageUrl) async {
  //   try {
  //     await FirebaseFirestore.instance.collection('categories').add({
  //       'name': nameController.text,
  //       'details': detailsController.text,
  //       'imageUrl': imageUrl,
  //       'timestamp': FieldValue.serverTimestamp(),
  //     });
  //   } catch (e) {
  //     print('Error uploading data: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      drawer: const DrawerScreen(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: detailsController,
              decoration: const InputDecoration(labelText: 'Details'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // final imageUrl = await uploadImageToFirebase();
                // if (imageUrl != null) {
                //   await uploadDataToFirestore(imageUrl);
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: Text('Image uploaded successfully!')));
                // } else {
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //       content: Text('Image upload failed or canceled.')));
                // }
              },
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 16.0),
            // Expanded(
            //   child: StreamBuilder<QuerySnapshot>(
            //     stream: FirebaseFirestore.instance
            //         .collection('categories')
            //         .snapshots(),
            //     builder: (BuildContext context,
            //         AsyncSnapshot<QuerySnapshot> snapshot) {
            //       if (!snapshot.hasData) {
            //         return Center(child: CircularProgressIndicator());
            //       }
            //       final List<DocumentSnapshot> documents = snapshot.data!.docs;
            //       return GridView.builder(
            //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 2,
            //           mainAxisSpacing: 4.0,
            //           crossAxisSpacing: 4.0,
            //         ),
            //         itemCount: documents.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           final imageUrl = documents[index]['imageUrl'];
            //           return imageUrl != null
            //               ? Image.network(imageUrl, fit: BoxFit.cover)
            //               : SizedBox();
            //         },
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
