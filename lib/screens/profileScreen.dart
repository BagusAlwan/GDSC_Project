import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc/resources/authMethod.dart';
import 'package:gdsc/resources/firestoreMethod.dart';
import 'package:gdsc/screens/mainScreen.dart';
import 'package:gdsc/utils/colors.dart';
import 'package:gdsc/utils/utils.dart';
import 'package:gdsc/widgets/followButton.dart';
import 'package:gdsc/widgets/post_cad.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  int followers = 0;
  int followings = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      followings = userSnap.data()!['following'].length;
      followers = userSnap.data()!['followers'].length;
      userData = userSnap.data()!;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      showSnackbar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              iconTheme: IconThemeData(color: PrimaryColor),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text(
                userData['name'],
                style: TextStyle(color: PrimaryColor),
              ),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: SecondaryColor,
                            backgroundImage: NetworkImage(userData['photoUrl']),
                            radius: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Text(userData['univ']),
                                Text(userData['program'])
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    buildStatColumn(followers, "followers"),
                                    buildStatColumn(followings, "following"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FirebaseAuth.instance.currentUser!.uid == widget.uid
                              ? FollowButton(
                                  function: () async {
                                    await AuthMethods().SignOut();
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const mainScreen(),
                                      ),
                                    );
                                  },
                                  backgroundColor: ThirdColor,
                                  borderColor: Colors.white,
                                  text: "Sign Out",
                                  textColor: Colors.black)
                              : isFollowing
                                  ? FollowButton(
                                      function: () async {
                                        await FirestoreMethods().followUser(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            userData['uid']);

                                        setState(() {
                                          isFollowing = false;
                                          followers--;
                                        });
                                      },
                                      backgroundColor: ThirdColor,
                                      borderColor: Colors.white,
                                      text: "Unfollow",
                                      textColor: Colors.black)
                                  : FollowButton(
                                      function: () async {
                                        await FirestoreMethods().followUser(
                                            FirebaseAuth
                                                .instance.currentUser!.uid,
                                            userData['uid']);
                                        setState(() {
                                          isFollowing = true;
                                          followers++;
                                        });
                                      },
                                      backgroundColor: ThirdColor,
                                      borderColor: Colors.white,
                                      text: "Follow",
                                      textColor: Colors.black,
                                    )
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          userData['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 1),
                        child: Text(
                          userData['bio'],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .where('uid', isEqualTo: widget.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        itemBuilder: ((context, index) {
                          DocumentSnapshot snap =
                              (snapshot.data! as dynamic).docs[index];

                          return PostCard(snap: snap);
                        }),
                      );
                    }),
              ],
            ),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: SecondaryColor),
          ),
        ),
      ],
    );
  }
}
