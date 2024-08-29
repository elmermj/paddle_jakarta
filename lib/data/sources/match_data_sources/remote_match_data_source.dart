import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paddle_jakarta/data/models/match_model.dart';

class RemoteMatchDataSource {
  final FirebaseFirestore _firestore;

  RemoteMatchDataSource(this._firestore);

  Future<List<MatchModel>> getMatches(int limit) async {
    final matchesDocumentsSnapshot = await _firestore.collection('matches').limit(limit).get();

    return matchesDocumentsSnapshot.docs.map((doc) {
      final matchData = doc.data();
      return MatchModel.fromJson(matchData);
    }).toList();
  }

  Future<List<MatchModel>> getMatchesByUserId(String userId, int limit) async {
    final matchesDocumentsSnapshot = await _firestore.collection('matches').where('teams', arrayContains: userId).get();
    return matchesDocumentsSnapshot.docs.map((doc) {
      final matchData = doc.data();
      return MatchModel.fromJson(matchData);
    }).toList();
  }

  Future<MatchModel> getMatchDetail(String matchId) async {
    final matchDocument = await _firestore.collection('matches').doc(matchId).get();
    return MatchModel.fromJson(matchDocument.data()!);
  }

  Future<void> createMatch(MatchModel match) async {
    final matchData = match.toJson();
    await _firestore.collection('matches').doc(match.matchId).set(matchData);
  }

  Future<void> finalizeMatch(MatchModel match) {
    final matchData = match.toJson();
    return _firestore.collection('matches').doc(match.matchId).update(matchData);
  }
}