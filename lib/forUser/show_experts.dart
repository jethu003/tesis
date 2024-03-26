import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tesis/admin_panel/booking_list.dart';

class ExpertsListPage extends StatefulWidget {
  const ExpertsListPage({Key? key}) : super(key: key);

  @override
  State<ExpertsListPage> createState() => _ExpertsListPageState();
}

class _ExpertsListPageState extends State<ExpertsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Experts List'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>const BookingListPage()));
              },
              icon: const Icon(Icons.list))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('experts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No experts available.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final expert = snapshot.data!.docs[index];
              final data = expert.data() as Map<String, dynamic>;
              List<dynamic> timeSlots = data['timeSlots'];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(data['imageUrl'] ?? 'fallback_image_url'),
                  ),
                  title: Text(data['name']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: timeSlots.map<Widget>((slot) {
                      DateTime start = (slot['start'] as Timestamp).toDate();
                      DateTime end = (slot['end'] as Timestamp).toDate();
                      String startTime =
                          '${start.hour}:${start.minute.toString().padLeft(2, '0')}';
                      String endTime =
                          '${end.hour}:${end.minute.toString().padLeft(2, '0')}';
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$startTime to $endTime'),
                          ElevatedButton(
                            onPressed: () {
                              // Implement booking functionality here
                              showDialog(
                                context: context,
                                builder: (context) => BookingDialog(
                                  expertId: expert.id,
                                  startTime: start,
                                  endTime: end,
                                ),
                              );
                            },
                            child: const Text('Book'),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BookingDialog extends StatefulWidget {
  final String expertId;
  final DateTime startTime;
  final DateTime endTime;

  const BookingDialog({super.key, 
    required this.expertId,
    required this.startTime,
    required this.endTime,
  });

  @override
  BookingDialogState createState() => BookingDialogState();
}

class BookingDialogState extends State<BookingDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:const Text('Book Expert'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration:const InputDecoration(labelText: 'Your Name'),
            ),
            TextField(
              controller: _contactController,
              decoration:const InputDecoration(labelText: 'Contact Information'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child:const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Implement booking confirmation logic
            String name = _nameController.text.trim();
            String contact = _contactController.text.trim();

            if (name.isNotEmpty && contact.isNotEmpty) {
              // Store booking details in Firestore
              FirebaseFirestore.instance.collection('bookings').add({
                'expertId': widget.expertId,
                'startTime': widget.startTime,
                'endTime': widget.endTime,
                'name': name,
                'contact': contact,
                'status': 'pending', // Initial status
              });

              // Close the dialog
              Navigator.pop(context);

              // Show a confirmation snackbar
              ScaffoldMessenger.of(context).showSnackBar(
              const  SnackBar(
                  content: Text('Booking request sent!'),
                ),
              );
            } else {
              // Show error message if fields are empty
              ScaffoldMessenger.of(context).showSnackBar(
              const  SnackBar(
                  content: Text('Please fill in all fields.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child:const Text('Book Now'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    super.dispose();
  }
}
