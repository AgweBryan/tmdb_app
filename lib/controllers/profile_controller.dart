import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tmdb_app/constants.dart';
import 'package:tmdb_app/controllers/inbox_controller.dart';
import 'package:tmdb_app/models/video.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get user => _user.value;

  final Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    List<Map<String, dynamic>> videos = [];
    dynamic myVideos = await firestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();

    for (int i = 0; i < myVideos.docs.length; i++) {
      final id = (myVideos.docs[i].data() as dynamic)['id'];
      final caption = (myVideos.docs[i].data() as dynamic)['caption'];
      final commentCount = (myVideos.docs[i].data() as dynamic)['commentCount'];
      final thumbnail = (myVideos.docs[i].data() as dynamic)['thumbnail'];
      final videoUrl = (myVideos.docs[i].data() as dynamic)['videoUrl'];
      final likes = (myVideos.docs[i].data() as dynamic)['likes'];
      final profilePhoto = (myVideos.docs[i].data() as dynamic)['profilePhoto'];
      final reports = (myVideos.docs[i].data() as dynamic)['reports'];
      final shareCount = (myVideos.docs[i].data() as dynamic)['shareCount'];
      final songName = (myVideos.docs[i].data() as dynamic)['songName'];
      final uid = (myVideos.docs[i].data() as dynamic)['uid'];
      final username = (myVideos.docs[i].data() as dynamic)['username'];

      final Video video = Video(
          caption: caption,
          commentCount: commentCount,
          id: id,
          shareCount: shareCount,
          likes: likes,
          reports: reports,
          profilePhoto: profilePhoto,
          songName: songName,
          thumbnail: thumbnail,
          uid: uid,
          username: username,
          videoUrl: videoUrl);

      videos.add(video.toJson());
    }

    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();

    final userData = userDoc.data() as dynamic;

    String name = userData['name'];

    String profilePhoto = userData['profilePhoto'];

    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    for (final item in myVideos.docs) {
      likes += (item.data()['likes'] as List).length;
    }

    final followerDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();

    final followingDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();

    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    _user.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'profilePhoto': profilePhoto,
      'name': name,
      'videos': videos,
    };

    update();
  }

  followUser() async {
    final followersDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();

    final followingDoc = await firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('followers')
        .doc(_uid.value)
        .get();

    if (!followersDoc.exists && !followingDoc.exists) {
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .set({});

      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});

      _user.value
          .update('followers', (value) => (int.parse(value) + 1).toString());

      InboxController().postInbox(_uid.value, 'started following you.');
    } else {
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user.uid)
          .delete();

      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();

      _user.value
          .update('followers', (value) => (int.parse(value) - 1).toString());

      InboxController().postInbox(_uid.value, 'stopped following you.');
    }
    _user.value.update('isFollowing', (value) => !value);
    update();
  }
}
