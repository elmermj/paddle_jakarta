import 'package:hive/hive.dart';
import 'package:paddle_jakarta/data/models/match_model.dart';

class LocalMatchDataSource {
  final Box<List<MatchModel>> _box;

  LocalMatchDataSource(this._box);
}