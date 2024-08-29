import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paddle_jakarta/data/models/timeline_item_model.dart';

class RemoteTimelineDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  RemoteTimelineDataSource(this._firestore, this._auth);

  Future<List<TimelineItemModel>> getMyTimelineItems(int? limit) async {
    limit ??= 10;
    final timelineItemsSnapshot = await _firestore
      .collection('users').doc(_auth.currentUser!.email).collection('timeline').limit(limit).get();

    return timelineItemsSnapshot.docs.map((doc) {
        final timelineItemData = doc.data();
        return TimelineItemModel.fromJson(timelineItemData);
      }).toList();
  }

  Future<List<TimelineItemModel>> loadMoreTimelineItems (int? limit, String timelineItemId) async {
    limit ??= 10;
    final timelineItemsSnapshot = await _firestore
      .collection('users').doc(_auth.currentUser!.email).collection('timeline').startAfterDocument(
        await _firestore.collection('users').doc(_auth.currentUser!.email).collection('timeline').doc(timelineItemId).get()
      ).limit(limit).get();

    return timelineItemsSnapshot.docs.map((doc) {
        final timelineItemData = doc.data();
        return TimelineItemModel.fromJson(timelineItemData);
      }).toList();
  }

  Future<void> saveTimelineItem(TimelineItemModel timelineItem) async {
    final timelineItemData = timelineItem.toJson();
    await _firestore.collection('users').doc(_auth.currentUser!.email).collection('timeline').add(timelineItemData);
  }
}