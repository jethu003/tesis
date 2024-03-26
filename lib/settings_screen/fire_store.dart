// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String userName = "No";
String userPhone = "NO";
String userEmail = "No";

class FirestroreService {
  final CollectionReference user =
      FirebaseFirestore.instance.collection("users");

  getUsers() async {
    try {
      QuerySnapshot querySnapshot = await user.get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        if (_auth.currentUser!.email == doc.id) {
          userName = doc["name"];
          userPhone = doc["phone"];
          userEmail = _auth.currentUser!.email ?? "No";
        } else {}
      }
    } catch (e) {
      print(e);
    }
  }
}
