import 'package:dartz/dartz.dart';
import 'package:paddle_jakarta/data/models/timeline_item_model.dart';
import 'package:paddle_jakarta/data/sources/timeline_data_sources/remote_timeline_data_source.dart';

abstract class TimelineRepository {
  Future<Either<Exception, void>> saveTimelineItem(TimelineItemModel timelineItem);
  Future<Either<Exception, List<TimelineItemModel>>> getMyTimelineItems(int? limit);
  Future<Either<Exception, List<TimelineItemModel>>> loadMoreTimelineItems(int? limit, String timelineItemId);
}

class TimelineRepositoryImpl implements TimelineRepository {
  final RemoteTimelineDataSource remoteData;

  TimelineRepositoryImpl(this.remoteData);
  
  @override
  Future<Either<Exception, List<TimelineItemModel>>> getMyTimelineItems(int? limit) async {
    try{
      return Right(await remoteData.getMyTimelineItems(limit));
    } on Exception catch (e) {
      return Left(e);
    }
  }
  
  @override
  Future<Either<Exception, List<TimelineItemModel>>> loadMoreTimelineItems(int? limit, String timelineItemId) async {
    try{
      return Right(await remoteData.loadMoreTimelineItems(limit, timelineItemId));
    } on Exception catch (e) {
      return Left(e);
    }
  }
  
  @override
  Future<Either<Exception, void>> saveTimelineItem(TimelineItemModel timelineItem) async {
    try{
      return Right(await remoteData.saveTimelineItem(timelineItem));
    } on Exception catch (e) {
      return Left(e);
    }
  }
}

  