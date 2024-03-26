import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tesis/home_screens/firebase_favorites.dart'; 

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FirebaseFav firebaseFav = FirebaseFav();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Container(
        color: Colors.grey[200],
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('favorites')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No favorites yet'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                return GestureDetector(
                  onTap: () {
                    // Handle onTap
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        // Display the image if available
                        if (data.containsKey('imageUrl'))
                          CircleAvatar(
                            backgroundImage: NetworkImage(data['imageUrl']),
                          )
                        else
                          const CircleAvatar(
                            child: Icon(Icons.image),
                          ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['name'] ?? 'Name not available',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                data['details'] ?? 'Details not available',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Simulate adding a favorite item (you can replace this with your actual logic)
          bool added = await firebaseFav.addToFavorites(
            'New Plant',
            'https://example.com/image.jpg',
            'Details of the new plant',
          );

          if (added) {
            // Show a snackbar if added successfully
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Added to favorites'),
                duration: Duration(seconds: 2),
              ),
            );
          } else {
            // Show an error snackbar if not added
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to add to favorites'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
