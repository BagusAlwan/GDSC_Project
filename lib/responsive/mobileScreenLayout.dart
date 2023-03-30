import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc/models/user.dart' as model;
import 'package:gdsc/utils/colors.dart';
import 'package:gdsc/utils/globalVariables.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: ScreensItems,
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: PrimaryColor,
          iconSize: 30,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                  color: _page == 0 ? Color(0xff462555) : Colors.white,
                ),
                label: '',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: _page == 1 ? Color(0xff462555) : Colors.white,
                ),
                label: '',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle_outlined,
                  color: _page == 2 ? Color(0xff462555) : Colors.white,
                ),
                label: '',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: _page == 3 ? Color(0xff462555) : Colors.white,
                ),
                label: '',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                  color: _page == 4 ? Color(0xff462555) : Colors.white,
                ),
                label: '',
                backgroundColor: Colors.white),
          ],
          onTap: navigationTapped,
        ),
      ),
    );
  }
}
