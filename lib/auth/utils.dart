// Create a CollectionReference called users that references the firestore collection
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> addUser() {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth _auth = FirebaseAuth.instance;

  return users
      .doc(_auth.currentUser.uid)
      .set({
        'uid': _auth.currentUser.uid,
        'email': _auth.currentUser.email,
        'profileImage': null,
        'ownedStickers': [],
        'availableStickers': [
          "sticker1.png",
          "sticker2.png",
          "sticker3.png",
          "sticker4.png"
        ]
      })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}

Future<Map<String, dynamic>> getUserDetails() async {
  String uid = FirebaseAuth.instance.currentUser.uid;

  return await FirebaseFirestore.instance
      .collection('users')
      .where("uid", isEqualTo: uid)
      .get()
      .then((event) {
    if (event.docs.isNotEmpty) {
      Map<String, dynamic> documentData =
          event.docs.single.data(); //if it is a single document
      print("--------------------");
      print(documentData);
      print("--------------------");

      return documentData;
    }
  }).catchError((e) => print("error fetching data: $e"));
}
