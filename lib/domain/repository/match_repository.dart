import 'package:dartz/dartz.dart';
import 'package:paddle_jakarta/data/models/match_model.dart';
import 'package:paddle_jakarta/data/sources/match_data_sources/local_match_data_source.dart';
import 'package:paddle_jakarta/data/sources/match_data_sources/remote_match_data_source.dart';

abstract class MatchRepository {
  Future<Either<Exception, List<MatchModel>>> getMatches(int? limit);
  Future<Either<Exception, List<MatchModel>>> getMatchesByUserId(String userId, int? limit);
  Future<Either<Exception, MatchModel>> getMatchDetail(String matchId);
  Future<Either<Exception, void>> createMatch(MatchModel match);
  Future<Either<Exception, void>> finalizeMatch(MatchModel match);
}

class MatchRepositoryImpl implements MatchRepository {
  final RemoteMatchDataSource remoteData;
  final LocalMatchDataSource localData;

  MatchRepositoryImpl(this.remoteData, this.localData);


  @override
  Future<Either<Exception, List<MatchModel>>> getMatches(int? limit) async {
    limit ??= 10;
    try {
      return Right(await remoteData.getMatches(limit));
    } on Exception catch (e) {
      return Left(e);
    }
  }
  
  @override
  Future<Either<Exception, void>> createMatch(MatchModel match) async {
    try {
      await remoteData.createMatch(match);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }
  
  @override
  Future<Either<Exception, MatchModel>> getMatchDetail(String matchId) async {
    try {      
      return Right(await remoteData.getMatchDetail(matchId));
    } on Exception catch (e) {
      return Left(e);
    }
  }
  
  @override
  Future<Either<Exception, List<MatchModel>>> getMatchesByUserId(String userId, int? limit) async {
    limit ??= 10;
    try {
      return Right(await remoteData.getMatchesByUserId(userId, limit));
    } on Exception catch (e) {
      return Left(e);
    }
  }
  
  @override
  Future<Either<Exception, void>> finalizeMatch(MatchModel match) async {
    try {
      await remoteData.finalizeMatch(match);
      return const Right(null);
    } on Exception catch (e) {
      return Left(e);
    }
  }

}