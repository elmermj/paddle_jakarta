import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paddle_jakarta/data/models/match_model.dart';

class RemoteMatchDataSource {
  final FirebaseFirestore _firestore;

  RemoteMatchDataSource(this._firestore);

  Future<List<MatchModel>> getMatches(int limit) async {
    try {
      final matchesDocumentsSnapshot = await _firestore.collection('matches').limit(limit).get();
      
      return matchesDocumentsSnapshot.docs.map((doc) {
        final matchData = doc.data();
        return MatchModel.fromJson(matchData);
      }).toList();
    } on Exception catch (e) {
      throw Exception('Failed to fetch matches data: $e');
    }
  }

  Future<List<MatchModel>> getMatchesByUserId(String userId, int limit) async {
    try {
      final matchesDocumentsSnapshot = await _firestore.collection('matches').where('teams', arrayContains: userId).get();
      return matchesDocumentsSnapshot.docs.map((doc) {
        final matchData = doc.data();
        return MatchModel.fromJson(matchData);
      }).toList();
    } on Exception catch (e) {
      throw Exception('Failed to fetch matches data: $e');
    }
  }

  Future<MatchModel> getMatchDetail(String matchId) async {
    try {
      final matchDocument = await _firestore.collection('matches').doc(matchId).get();
      return MatchModel.fromJson(matchDocument.data()!);
    } on Exception catch (e) {
      throw Exception('Failed to fetch match detail: $e');
    }
  }

  Future<void> createMatch(MatchModel match) async {
    try {
      final matchData = match.toJson();
      await _firestore.collection('matches').doc(match.matchId).set(matchData);
    } on Exception catch (e) {
      throw Exception('Failed to create match: $e');
    }
  }

  Future<void> finalizeMatch(MatchModel match) {
    try {
      final matchData = match.toJson();
      return _firestore.collection('matches').doc(match.matchId).update(matchData);
    } on Exception catch (e) {
      throw Exception('Failed to finalize match: $e');
    }
  }
}