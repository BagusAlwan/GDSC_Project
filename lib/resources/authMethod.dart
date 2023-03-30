import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gdsc/models/user.dart' as model;
import 'package:gdsc/resources/storageMethod.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection("users").doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // dign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required String bday,
    required String univ,
    required String program,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          bday.isNotEmpty ||
          univ.isNotEmpty ||
          program.isNotEmpty ||
          bio.isNotEmpty /*|| file != null*/) {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        // add user to database

        model.User user = model.User(
          name: name,
          uid: cred.user!.uid,
          email: email,
          bday: bday,
          univ: univ,
          program: program,
          bio: bio,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //Logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Error Occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all te fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> SignOut() async {
    await _auth.signOut();
  }
}
