import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HerbListScreen extends StatelessWidget {
  const HerbListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Herb List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('herbs').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              String documentId = document.id;

              // Check if name and description are not null
              String name = data['name'] ?? 'Unknown';
              String description =
                  data['description'] ?? 'No description available';

              return ListTile(
                title: Text(name),
                subtitle: Text(description),
                onTap: () {
                  // Call a function to delete the document when the item is clicked
                  deleteDocument(documentId);
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void deleteDocument(String documentId) {
    FirebaseFirestore.instance
        .collection('herbs')
        .doc(documentId)
        .delete()
        .then((_) {
      print("Document deleted successfully");
    }).catchError((error) {
      print("Error deleting document: $error");
    });
  }
}
