import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DeleteExpert extends StatefulWidget {
  const DeleteExpert({Key? key}) : super(key: key);

  @override
  State<DeleteExpert> createState() => _DeleteExpertState();
}

class _DeleteExpertState extends State<DeleteExpert> {
  Future<void> _deleteExpert(String expertId) async {
    try {
      await FirebaseFirestore.instance
          .collection('experts')
          .doc(expertId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Expert deleted successfully.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete expert: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Delete Expert'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('experts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No experts available.'));
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
                      backgroundImage: NetworkImage(
                          data['imageUrl'] ?? 'fallback_image_url')),
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
                      return Text('$startTime to $endTime');
                    }).toList(),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Delete Expert'),
                            content: Text(
                                'Are you sure you want to delete this expert?'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Delete'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _deleteExpert(expert.id); // Delete the expert
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
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
