import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget buildHorizontalContainerList(BuildContext context, BoxDecoration decoration) {
  return SizedBox(
    height: 100, // Adjust the height as needed
    child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('herbs').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        List<DocumentSnapshot> documents = snapshot.data!.docs;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: documents.length,
          itemBuilder: (BuildContext context, int index) {
            String imageUrl = documents[index]['imageUrl'];
            return Container(
              width: 100, 
              margin:const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: decoration,
              // ignore: unnecessary_null_comparison
              child: imageUrl != null
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    )
                  :const SizedBox(), 
            );
          },
        );
      },
    ),
  );
}
