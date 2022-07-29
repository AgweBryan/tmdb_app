import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String uid;
  String id;
  List likes;
  List reports;
  int commentCount;
  List shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilePhoto;

  Video({
    required this.caption,
    required this.commentCount,
    required this.id,
    required this.shareCount,
    required this.likes,
    required this.reports,
    required this.profilePhoto,
    required this.songName,
    required this.thumbnail,
    required this.uid,
    required this.username,
    required this.videoUrl,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'profilePhoto': profilePhoto,
        'id': id,
        'likes': likes,
        'reports': reports,
        'commentCount': commentCount,
        'shareCount': shareCount,
        'songName': songName,
        'caption': caption,
        'videoUrl': videoUrl,
        'thumbnail': thumbnail,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    final snapshot = snap.data() as Map<String, dynamic>;

    return Video(
        caption: snapshot['caption'],
        commentCount: snapshot['commentCount'],
        id: snapshot['id'],
        shareCount: snapshot['shareCount'],
        likes: snapshot['likes'],
        reports: snapshot['reports'],
        profilePhoto: snapshot['profilePhoto'],
        songName: snapshot['songName'],
        thumbnail: snapshot['thumbnail'],
        uid: snapshot['uid'],
        username: snapshot['username'],
        videoUrl: snapshot['videoUrl']);
  }
}
