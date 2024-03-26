import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tesis/admin_panel/custom_drawer.dart';
import 'package:tesis/home_screens/components.dart';
import 'package:tesis/loginScreens/common_widgets.dart';
import 'package:tesis/utilis/app_colors.dart';

class HerbsPage extends StatefulWidget {
  const HerbsPage({Key? key}) : super(key: key);

  @override
  HerbsPageState createState() => HerbsPageState();
}

class HerbsPageState extends State<HerbsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  final HomePage home = HomePage();
  final CommonWidgets common = CommonWidgets();

  List<Map<String, dynamic>> herbsData = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestore();
  }

  Future<String?> uploadImageToFirebase() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return null;

      final file = File(pickedFile.path);

      final fileName =
          '${DateTime.now().microsecondsSinceEpoch}-${pickedFile.path.split('/').last}';
      final Reference ref =
          FirebaseStorage.instance.ref().child('herbs/$fileName');

      final TaskSnapshot uploadTask = await ref.putFile(file);
      final imageUrl = await uploadTask.ref.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<void> uploadDataToFirestore(String imageUrl) async {
    try {
      await FirebaseFirestore.instance.collection('herbs').add({
        'name': nameController.text,
        'details': detailsController.text,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error uploading data: $e');
    }
  }

  Future<void> fetchDataFromFirestore() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('herbs').get();
      setState(() {
        herbsData = snapshot.docs.map((DocumentSnapshot doc) {
          return {
            'id': doc.id,
            'name': doc['name'],
            'details': doc['details'],
            'imageUrl': doc['imageUrl'],
          };
        }).toList();
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> deleteHerb(String id) async {
    try {
      await FirebaseFirestore.instance.collection('herbs').doc(id).delete();
      setState(() {
        herbsData.removeWhere((element) => element['id'] == id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Herb deleted successfully!'),
        ),
      );
    } catch (e) {
      print('Error deleting herb: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error deleting herb. Please try again later.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: const Text('Herbs Page'),
        backgroundColor: AppColors.backGroundColor,
        centerTitle: false,
      ),
      drawer: const DrawerScreen(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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
            common.buildCustomButton(context, 'Save Herbs', () async {
              final imageUrl = await uploadImageToFirebase();
              if (imageUrl != null) {
                await uploadDataToFirestore(imageUrl);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Image uploaded successfully!'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Image upload failed or canceled.'),
                  ),
                );
              }
             
              fetchDataFromFirestore();
            }, AppColors.primaryColor, AppColors.whiteForText,
                const EdgeInsets.symmetric(horizontal: 1)),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: herbsData.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Delete Herb?'),
                            content: const Text(
                                'Are you sure you want to delete this herb?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  deleteHerb(herbsData[index]['id']);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.network(
                              herbsData[index]['imageUrl'],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  herbsData[index]['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  herbsData[index]['details'],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
