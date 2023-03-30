import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc/screens/addPostScreen.dart';
import 'package:gdsc/screens/homeScreen.dart';
import 'package:gdsc/screens/profileScreen.dart';
import 'package:gdsc/screens/searchScreen.dart';

const webScreenSize = 600;

List<Widget> ScreensItems = [
  const HomeScreen(),
  const Text("Chat"),
  const AddPostScreen(),
  const SearchScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
