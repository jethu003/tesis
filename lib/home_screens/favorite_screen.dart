import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Container(
        color: Colors.grey[200],
        child: StreamBuilder<QuerySnapshot>(
          stream: _getFavoritesStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 10,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                       
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
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
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Stream<QuerySnapshot> _getFavoritesStream() {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;
      return FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .snapshots();
    } else {
      // Return an empty stream if user is not signed in
      return const Stream.empty();
    }
  }
}
