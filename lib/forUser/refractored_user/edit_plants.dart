import 'package:flutter/material.dart';
import 'package:tesis/hive_db_functions/db_functions/hive_addplants.dart';
import 'package:tesis/hive_db_functions/hive_models/add_plants.dart';

class EditPlantDetails extends StatefulWidget {
  final String initialName;
  final String initialDescription;
  final String intialLocation;
  final String id;
  final String? imagePath;

  const EditPlantDetails({
    Key? key,
    this.imagePath,
    required this.initialName,
    required this.initialDescription,
    required this.intialLocation,
    required this.id,
  }) : super(key: key);

  @override
  State<EditPlantDetails> createState() => _EditPlantDetailsState();
}

class _EditPlantDetailsState extends State<EditPlantDetails> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.initialName);
    _descriptionController =
        TextEditingController(text: widget.initialDescription);
    _locationController = TextEditingController(text: widget.intialLocation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Plant Details'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            final updatedId = widget.id;

            final updatedName = _nameController.text;
            final updatedDescription = _descriptionController.text;
            final updatedLocation = _locationController.text;
            AddPlantsDb.instance.updatePlantdetails(
              AddPlantModel(
                  id: updatedId,
                  description: updatedDescription,
                  location: updatedLocation,
                  name: updatedName,
                  imagePath: widget.imagePath),
            );
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
