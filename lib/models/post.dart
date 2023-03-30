import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String postUrl;
  final String name;
  final String postId;
  final datePublished;
  final String profileImg;
  final likes;

  const Post({
    required this.description,
    required this.uid,
    required this.postId,
    required this.name,
    required this.postUrl,
    required this.datePublished,
    required this.profileImg,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "postId": postId,
        "name": name,
        "postUrl": postUrl,
        "datePublished": datePublished,
        "profileImg": profileImg,
        "likes": likes,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapshot['description'],
      uid: snapshot['uid'],
      postId: snapshot['postId'],
      name: snapshot['name'],
      postUrl: snapshot['postUrl'],
      datePublished: snapshot['datePublished'],
      profileImg: snapshot['profileImg'],
      likes: snapshot['likes'],
    );
  }
}
