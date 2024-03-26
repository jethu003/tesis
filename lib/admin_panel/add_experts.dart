import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as Path;


class AddExperts extends StatefulWidget {
  const AddExperts({Key? key}) : super(key: key);

  @override
  State<AddExperts> createState() => _AddExpertsState();
}

class _AddExpertsState extends State<AddExperts> {
  final TextEditingController _nameController = TextEditingController();
  File? _image;
  List<Map<String, DateTime>> _timeSlots = [];

  void _addTimeSlot(DateTime start) {
    setState(() {
      _timeSlots
          .add({'start': start, 'end': start.add(const Duration(hours: 1))});
    });
  }

  Future<void> _saveExpert() async {
    final picker = ImagePicker();

    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter expert name.'),
        ),
      );
      return;
    }

    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image.'),
        ),
      );
      return;
    }

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No image selected.'),
        ),
      );
      return;
    }

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child("images/${Path.basename(_image!.path)}");
    UploadTask uploadTask = ref.putFile(_image!);
    await uploadTask.whenComplete(() async {
      String imageUrl = await ref.getDownloadURL();
      final expert = Expert(
        name: _nameController.text,
        imageUrl: imageUrl,
        timeSlots: _timeSlots,
      );
      await FirebaseFirestore.instance
          .collection('experts')
          .add(expert.toJson());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Expert added successfully.'),
        ),
      );
      _nameController.clear();
      setState(() {
        _timeSlots = [];
        _image = null;
      });
    // ignore: body_might_complete_normally_catch_error
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add expert: $onError'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expert')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            _image == null
                ? ElevatedButton(
                    onPressed: () async {
                      final picker = ImagePicker();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        if (pickedFile != null) {
                          _image = File(pickedFile.path);
                        } else {
                          print('No image selected.');
                        }
                      });
                    },
                    child: const Text('Select Image'),
                  )
                : Image.file(_image!, height: 100),
            const SizedBox(height: 16.0),
            const Text('Time Slots:', style: TextStyle(fontSize: 18.0)),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _timeSlots.length,
              itemBuilder: (context, index) {
                final slot = _timeSlots[index];
                return ListTile(
                  title: Text('${slot['start']} - ${slot['end']}'),
                );
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final selectedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selectedTime != null) {
                  _addTimeSlot(DateTime.now().add(Duration(
                    hours: selectedTime.hour,
                    minutes: selectedTime.minute,
                  )));
                }
          
              },
              child: const Text('Add Time Slot'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _saveExpert();
              },
              child: const Text('Save Expert'),
            ),
          ],
        ),
      ),
    );
  }
}

class Expert {
  String name;
  String imageUrl;
  List<Map<String, DateTime>> timeSlots;

  Expert({
    required this.name,
    required this.imageUrl,
    required this.timeSlots,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'timeSlots': timeSlots
          .map((slot) => {'start': slot['start'], 'end': slot['end']})
          .toList(),
    };
  }
}
