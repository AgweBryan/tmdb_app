import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tmdb_app/constants.dart';
import 'package:tmdb_app/models/video.dart';
import 'package:tmdb_app/views/screens/home_screen.dart';
import 'package:tmdb_app/views/screens/preloader_screen.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  _compressVideo(String videoPath) async {
    final compressVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.DefaultQuality,
    );
    return compressVideo!.file;
  }

  // changed videoFile to videoPath
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));

    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  // Upload video
  uploadVideo(
      String songName, String caption, File videoFile, String videoPath) async {
    try {
      bool uploading = true;

      if (uploading) {
        Get.to(PreloaderScreen());
      }

      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();

      // get id
      final allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;

      // changed videoFile to videoPath
      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
      String thumbnail = await _uploadImageToStorage('Video $len', videoPath);

      Video video = Video(
          caption: caption,
          commentCount: 0,
          id: 'videos $len',
          shareCount: [],
          likes: [],
          reports: [],
          profilePhoto:
              (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
          songName: songName,
          thumbnail: thumbnail,
          uid: uid,
          username: (userDoc.data()! as Map<String, dynamic>)['name'],
          videoUrl: videoUrl);

      await firestore
          .collection('videos')
          .doc('videos $len')
          .set(video.toJson());
      uploading = false;
      if (!uploading) {
        Get.offAll(HomeScreen());
      }
      // Get.back();
    } catch (e) {
      Get.snackbar('Error Uploading Video', e.toString());
    }
  }
}
