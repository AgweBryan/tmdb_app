import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tmdb_app/constants.dart';
import 'package:tmdb_app/models/video.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();

    // Show video real time after uploads
    _videoList.bindStream(
        firestore.collection('videos').snapshots().map((QuerySnapshot query) {
      List<Video> retVal = [];
      for (final element in query.docs) {
        retVal.add(Video.fromSnap(element));
      }
      return retVal;
    }));
  }

  likeVideo(String id) async {
    final doc = await firestore.collection('videos').doc(id).get();

    final uid = authController.user.uid;
    if ((doc.data() as dynamic)['likes'].contains(uid)) {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }

  shareVideo(Video videoData) async {
    final doc = await firestore.collection('videos').doc(videoData.id).get();

    final uid = authController.user.uid;
    if ((doc.data() as dynamic)['shareCount'].contains(uid)) {
      await Share.share(
          'Check out this awesome video!! \n\n${videoData.videoUrl}');
    } else {
      await Share.share(
          'Check out this awesome video!! \n\n${videoData.videoUrl}');

      await firestore.collection('videos').doc(videoData.id).update({
        'shareCount': FieldValue.arrayUnion([uid])
      });
    }
  }

  reportVideo(String id) async {
    final doc = await firestore.collection('videos').doc(id).get();

    final uid = authController.user.uid;

    if ((doc.data() as dynamic)['reports'].contains(uid)) {
      await firestore.collection('videos').doc(id).update({
        'reports': FieldValue.arrayRemove([uid])
      });
    } else {
      await firestore.collection('videos').doc(id).update({
        'reports': FieldValue.arrayUnion([uid])
      });
    }
  }
}
