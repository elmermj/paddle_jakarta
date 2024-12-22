import 'package:paddle_jakarta/data/models/user_model.dart';
import 'package:paddle_jakarta/features/leaderboard/data/models/match_response.dart';

class LeaderboardModel {
  final List<UserModel>? users;
  final MatchResponse? matchType;
  final int? page;

  LeaderboardModel({this.users, this.matchType, this.page});
}