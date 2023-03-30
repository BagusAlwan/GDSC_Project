import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gdsc/screens/profileScreen.dart';
import 'package:gdsc/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(
                labelText: 'Search for a user',
                labelStyle: TextStyle(color: PrimaryColor)),
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUsers = true;
              });
              print(_);
            },
          ),
        ),
        body: Column(
          children: [
            Divider(),
            isShowUsers
                ? FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .where(
                          'name',
                          isGreaterThanOrEqualTo: searchController.text,
                        )
                        .get(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => ProfileScreen(
                                          uid: (snapshot.data! as dynamic)
                                              .docs[index]['uid']))),
                              child: ListTile(
                                  leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          (snapshot.data! as dynamic)
                                              .docs[index]['photoUrl'])),
                                  title: Text((snapshot.data! as dynamic)
                                      .docs[index]['name'])),
                            );
                          });
                    },
                  )
                : Center(
                    child: Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Text(
                      'Search for your Friends',
                      style: TextStyle(
                          color: SecondaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
          ],
        ));
  }
}
