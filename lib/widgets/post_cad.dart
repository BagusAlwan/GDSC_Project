import 'package:flutter/material.dart';
import 'package:gdsc/models/user.dart';
import 'package:gdsc/providers/user_provider.dart';
import 'package:gdsc/resources/firestoreMethod.dart';
import 'package:gdsc/screens/commentScreen.dart';
import 'package:gdsc/utils/colors.dart';
import 'package:gdsc/widgets/likeAnimation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Container(
        width: 360,
        height: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: ThirdColor),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                  .copyWith(right: 0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(widget.snap['profileImg']),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.snap['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                              DateFormat.yMMMd().format(
                                widget.snap['datePublished'].toDate(),
                              ),
                              style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: IconButton(
                        iconSize: 30,
                        onPressed: (() =>
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CommentScreen(
                                snap: widget.snap,
                              ),
                            ))),
                        icon: Icon(
                          Icons.maps_ugc_outlined,
                          color: SecondaryColor,
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 13,
            ),
            GestureDetector(
              onDoubleTap: () async {
                await FirestoreMethods().likePost(
                    widget.snap['postId'], user.uid, widget.snap['likes']);
                setState(() {
                  isLikeAnimating = true;
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 220,
                    width: 325,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.snap['postUrl']),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: isLikeAnimating ? 1 : 0,
                    child: LikeAnimation(
                      child: const Icon(Icons.favorite,
                          color: SecondaryColor, size: 120),
                      isAnimating: isLikeAnimating,
                      duration: const Duration(milliseconds: 400),
                      onEnd: () {
                        setState(() {
                          isLikeAnimating = false;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: Row(
                children: [
                  Container(
                    width: 260,
                    child: Text(
                      widget.snap['description'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        children: [
                          LikeAnimation(
                            isAnimating:
                                widget.snap['likes'].contains(user.uid),
                            smallLike: true,
                            child: IconButton(
                                iconSize: 40,
                                onPressed: () async {
                                  await FirestoreMethods().likePost(
                                      widget.snap['postId'],
                                      user.uid,
                                      widget.snap['likes']);
                                },
                                icon: widget.snap['likes'].contains(user.uid)
                                    ? Icon(
                                        Icons.favorite,
                                        color: SecondaryColor,
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        color: SecondaryColor,
                                      )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 5,
                            ),
                            child: Text('${widget.snap['likes'].length} likes'),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
