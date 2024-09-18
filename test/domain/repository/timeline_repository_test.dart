import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:paddle_jakarta/data/sources/timeline_data_sources/remote_timeline_data_source.dart';
import 'package:paddle_jakarta/domain/repository/timeline_repository.dart';
import 'package:paddle_jakarta/data/models/timeline_item_model.dart';

import 'timeline_repository_test.mocks.dart';


@GenerateNiceMocks([MockSpec<RemoteTimelineDataSource>()])
void main() {
  late TimelineRepositoryImpl repository;
  late MockRemoteTimelineDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteTimelineDataSource();
    repository = TimelineRepositoryImpl(mockRemoteDataSource);
  });
  final timelineItems = [
    TimelineItemModel(timelineItemId: '1', title: 'Test content', type: 'type', timestamp: Timestamp.now())
  ];
  group('getMyTimelineItems', () {
    
    
    test('should return timeline items on success', () async {
      when(mockRemoteDataSource.getMyTimelineItems(any)).thenAnswer((_) async => timelineItems);

      final result = await repository.getMyTimelineItems(10);

      expect(result, Right(timelineItems));
      verify(mockRemoteDataSource.getMyTimelineItems(10)).called(1);
    });

    test('should return Exception on failure', () async {
      when(mockRemoteDataSource.getMyTimelineItems(any)).thenThrow(Exception('Error'));

      final result = await repository.getMyTimelineItems(10);

      expect(result, isA<Left<Exception, List<TimelineItemModel>>>());
      verify(mockRemoteDataSource.getMyTimelineItems(10)).called(1);
    });
  });

  group('loadMoreTimelineItems', () {

    test('should return more timeline items on success', () async {
      when(mockRemoteDataSource.loadMoreTimelineItems(any, any))
          .thenAnswer((_) async => timelineItems);

      final result = await repository.loadMoreTimelineItems(10, 'timelineId');

      expect(result, Right(timelineItems));
      verify(mockRemoteDataSource.loadMoreTimelineItems(10, 'timelineId')).called(1);
    });

    test('should return Exception on failure', () async {
      when(mockRemoteDataSource.loadMoreTimelineItems(any, any))
          .thenThrow(Exception('Error'));

      final result = await repository.loadMoreTimelineItems(10, 'timelineId');

      expect(result, isA<Left<Exception, List<TimelineItemModel>>>());
      verify(mockRemoteDataSource.loadMoreTimelineItems(10, 'timelineId')).called(1);
    });
  });

  group('saveTimelineItem', () {
    final timelineItem = timelineItems[0];

    test('should save timeline item on success', () async {
      when(mockRemoteDataSource.saveTimelineItem(any))
          .thenAnswer((_) async => Future.value());

      final result = await repository.saveTimelineItem(timelineItem);

      expect(result, Right(null));
      verify(mockRemoteDataSource.saveTimelineItem(timelineItem)).called(1);
    });

    test('should return Exception on failure', () async {
      when(mockRemoteDataSource.saveTimelineItem(any)).thenThrow(Exception('Error'));

      final result = await repository.saveTimelineItem(timelineItem);

      expect(result, isA<Left<Exception, void>>());
      verify(mockRemoteDataSource.saveTimelineItem(timelineItem)).called(1);
    });
  });
}
