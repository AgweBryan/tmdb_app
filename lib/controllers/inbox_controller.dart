import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tmdb_app/constants.dart';
import 'package:tmdb_app/models/inbox.dart';

class InboxController extends GetxController {
  final Rx<List<Inbox>> _inbox = Rx<List<Inbox>>([]);

  List<Inbox> get inboxes => _inbox.value;

  @override
  void onInit() {
    super.onInit();
    _inbox.bindStream(firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('inbox')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Inbox> retValue = [];
      for (var element in query.docs) {
        retValue.add(Inbox.fromSnap(element));
      }
      return retValue;
    }));
  }

  postInbox(String id, String message) async {
    final currentUserDoc = await firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('inbox')
        .get();

    final userDoc = await firestore.collection('users').doc(id).get();

    int len = currentUserDoc.docs.length;

    Inbox inbox = Inbox(
      username: (userDoc.data() as dynamic)['name'],
      message: message.trim(),
      datePublished: DateTime.now(),
      profilePhoto: (userDoc.data() as dynamic)['profilePhoto'],
      uid: authController.user.uid,
      id: 'Inbox $len',
    );

    await firestore
        .collection('users')
        .doc(id)
        .collection('inbox')
        .doc('Inbox $len')
        .set(inbox.toJson());
  }
}
