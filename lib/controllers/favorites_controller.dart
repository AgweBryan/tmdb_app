import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tmdb_app/constants.dart';
import 'package:tmdb_app/models/video.dart';

class FavoritesController extends GetxController {
  final Rx<List<Video>> _favVideos = Rx<List<Video>>([]);

  List<Video> get favVideos => _favVideos.value;

  @override
  void onInit() {
    super.onInit();
    _favVideos.bindStream(firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('favorites')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Video> retValue = [];
      for (var element in query.docs) {
        retValue.add(Video.fromSnap(element));
      }
      return retValue;
    }));
  }

  removeFromFavorites(Video data) async {
    try {
      // Get user
      final currentUserDoc = await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('favorites')
          .get();

      int len = currentUserDoc.docs.length;

      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('favorites')
          .doc('Fav $len')
          .delete()
          .then((value) => Get.snackbar('Success',
              'Video removed from favorites. Restart app to see changes'));
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  addVideoToFavorites(Video data) async {
    try {
      // Get user
      final currentUserDoc = await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('favorites')
          .get();

      int len = currentUserDoc.docs.length + 1;

      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('favorites')
          .doc('Fav $len')
          .set(data.toJson());

      Get.snackbar('Success', 'Video added to favorites successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
