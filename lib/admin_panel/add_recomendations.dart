import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tesis/loginScreens/common_widgets.dart';
import 'package:tesis/utilis/app_colors.dart';

class RecommendationsPage extends StatefulWidget {
  const RecommendationsPage({Key? key}) : super(key: key);

  @override
  RecommendationsPageState createState() => RecommendationsPageState();
}

class RecommendationsPageState extends State<RecommendationsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  List<Map<String, dynamic>> data = [];
  final CommonWidgets common = CommonWidgets();

  @override
  void initState() {
    super.initState();
    fetchDataFromFirestores();
  }

  Future<void> fetchDataFromFirestores() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('recomended').get();
      setState(() {
        data = snapshot.docs.map((DocumentSnapshot doc) {
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

  Future<void> deleteItem(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('recomended')
          .doc(id)
          .delete();
      setState(() {
        data.removeWhere((element) => element['id'] == id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item deleted successfully!'),
        ),
      );
    } catch (e) {
      print('Error deleting item: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error deleting item. Please try again later.'),
        ),
      );
    }
  }

  Future<String?> uploadImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return null;

      final file = File(pickedFile.path);
      final fileName =
          '${DateTime.now().microsecondsSinceEpoch}-${pickedFile.path.split('/').last}';
      final Reference ref =
          FirebaseStorage.instance.ref().child('recomended/$fileName');
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
      await FirebaseFirestore.instance.collection('recomended').add({
        'name': nameController.text,
        'details': detailsController.text,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error uploading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommendations Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'name'),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: detailsController,
              decoration: const InputDecoration(labelText: 'details'),
            ),
            const SizedBox(
              height: 16,
            ),
            common.buildCustomButton(context, 'save recommendations', () async {
              final imageUrl = await uploadImage();
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
              fetchDataFromFirestores();
            }, AppColors.primaryColor, AppColors.whiteForText,
                const EdgeInsets.symmetric(horizontal: 1)),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete Item'),
                            content: const Text(
                                'Are you sure you want to delete this item?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  deleteItem(data[index]['id']);
                                  Navigator.pop(context);
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.network(
                              data[index]['imageUrl'],
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index]['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
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
