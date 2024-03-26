import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFav {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> addToFavorites(
      String name, String imageUrl, String details) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String uid = user.uid;

        CollectionReference favoritesCollection =
            _firestore.collection('users').doc(uid).collection('favorites');

        Map<String, dynamic> favoriteData = {
          'name': name,
          'imageUrl': imageUrl,
          'details': details,
        };

        await favoritesCollection.add(favoriteData);

        return true;
      } else {
        print('User not signed in.');
        return false;
      }
    } catch (e) {
      print('Error adding to favorites: $e');
      return false;
    }
  }

  Future<bool> removeFromFavorites(String name) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        String uid = user.uid;

        CollectionReference favoritesCollection =
            _firestore.collection('users').doc(uid).collection('favorites');

        QuerySnapshot querySnapshot = await favoritesCollection
            .where('name', isEqualTo: name)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
        
          await querySnapshot.docs.first.reference.delete();
          return true;
        } else {
          print('Item not found in favorites.');
          return false;
        }
      } else {
        print('User not signed in.');
        return false;
      }
    } catch (e) {
      print('Error removing from favorites: $e');
      return false;
    }
  }
}
