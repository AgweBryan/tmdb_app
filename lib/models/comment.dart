import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username;
  String comment;
  final dynamic datePublished;
  List likes;
  String profilePhoto;
  String uid;
  String id;

  Comment({
    required this.comment,
    required this.datePublished,
    required this.id,
    required this.uid,
    required this.likes,
    required this.profilePhoto,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'comment': comment,
        'datePublished': datePublished,
        'likes': likes,
        'profilePhoto': profilePhoto,
        'uid': uid,
        'id': id,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    final snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
        comment: snapshot['comment'],
        datePublished: snapshot['datePublished'],
        id: snapshot['id'],
        uid: snapshot['uid'],
        likes: snapshot['likes'],
        profilePhoto: snapshot['profilePhoto'],
        username: snapshot['username']);
  }
}
