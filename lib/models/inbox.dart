import 'package:cloud_firestore/cloud_firestore.dart';

class Inbox {
  String username;
  String message;
  final dynamic datePublished;
  String profilePhoto;
  String uid;
  String id;

  Inbox({
    required this.message,
    required this.datePublished,
    required this.uid,
    required this.id,
    required this.profilePhoto,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'comment': message,
        'datePublished': datePublished,
        'profilePhoto': profilePhoto,
        'uid': uid,
        'id': id,
      };

  static Inbox fromSnap(DocumentSnapshot snap) {
    final snapshot = snap.data() as Map<String, dynamic>;
    return Inbox(
        message: snapshot['message'],
        id: snapshot['id'],
        datePublished: snapshot['datePublished'],
        uid: snapshot['uid'],
        profilePhoto: snapshot['profilePhoto'],
        username: snapshot['username']);
  }
}
