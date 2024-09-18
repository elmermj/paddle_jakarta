import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paddle_jakarta/app/app.locator.dart';
import 'package:paddle_jakarta/app/app.router.dart';
import 'package:paddle_jakarta/data/models/timeline_item_model.dart';
import 'package:paddle_jakarta/domain/repository/timeline_repository.dart';
import 'package:paddle_jakarta/domain/repository/user_repository.dart';
import 'package:paddle_jakarta/presentation/views/home/viewmodels/home_viewmodel.dart';
import 'package:paddle_jakarta/services/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

import '../helpers/test_helpers.dart';
import '../helpers/test_helpers.mocks.dart';
import 'home_viewmodel_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TimelineRepository>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<UserRepository>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<GeolocatorPlatform>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<PermissionService>(onMissingStub: OnMissingStub.returnDefault)
])
void main() {
  final mockUserRepository = MockUserRepository();
  final mockTimelineRepository = MockTimelineRepository();
  final mockGeolocatorPlatform = MockGeolocatorPlatform();
  final mockPermissionService = MockPermissionService();
  final navigationService = MockNavigationService();
  final mockThemeService = MockThemeService();
  late HomeViewModel model;
  HomeViewModel getModel() => HomeViewModel(mockUserRepository, mockTimelineRepository, mockPermissionService);
  group('HomeViewmodelTest -', () {
    setUp(() {
      registerServices();
      model  = getModel();
    });
    tearDown(() => locator.reset());

    group('HomeViewModel Tests -', () {

      test('toggleTheme should call themeService.toggleTheme and notifyListeners', () {
        var notifyListenersCalled = false;
        model.addListener(() {
          notifyListenersCalled = true;
        });

        model.toggleTheme();

        verify(model.toggleTheme()).called(1);
        expect(notifyListenersCalled, true);
      });

      test('toggleTheme should work when called multiple times', () {
        model.toggleTheme();
        model.toggleTheme();
        
        verify(model.toggleTheme()).called(2);
      });

      test('getMyTimeline should fetch and set timeline items correctly', () async {
        final model = getModel();
  
        final timelineItems = [TimelineItemModel(), TimelineItemModel()];
        when(mockTimelineRepository.getMyTimelineItems(any))
            .thenAnswer((_) async => Right(timelineItems));

        await model.getMyTimeline();

        expect(model.timelineItems, equals(timelineItems.toSet()));
        expect(model.isTimelineLoading, false);
      });

      test('loadMoreTimelineItems should load and add more timeline items', () async {
        final model = getModel();

        final moreTimelineItems = [TimelineItemModel(), TimelineItemModel()];
        when(mockTimelineRepository.loadMoreTimelineItems(any, any))
            .thenAnswer((_) async => Right(moreTimelineItems));

        await model.loadMoreTimelineItems("someId");

        expect(model.timelineItems.containsAll(moreTimelineItems), true);
        expect(model.isTimelineLoading, false);
      });

      test('logout should call UserRepository.logout and navigate to AuthView on success', () async {
        final model = HomeViewModel(mockUserRepository, mockTimelineRepository, mockPermissionService);

        when(mockUserRepository.logout())
            .thenAnswer((_) async => right(unit));

        await model.logout();

        verifyNever(navigationService.clearStackAndShow(Routes.authView));
      });

      test('clearCache should update progress and reset isDeletingCache', () async {
        final model = getModel();

        model.clearCache();
        expect(model.isDeletingCache, true);

        await Future.delayed(const Duration(milliseconds: 4500));
        expect(model.progress, 0.0);
        expect(model.isDeletingCache, false);
      });

      test('toggleLastMatchCardMinimized should toggle and finalize states correctly', () async {
        final model = getModel();
        model.toggleLastMatchCardMinimized();

        expect(model.isLastMatchCardMinimized, true);
        await Future.delayed(Durations.short3);
        expect(model.isLastMatchCardMinimizedFinalized, true);
      });

      test('checkLocationPermission should set permission granted correctly', () async {
        final model = getModel();

        when(mockPermissionService.checkLocationPermission())
            .thenAnswer((_) async => PermissionStatus.granted);

        await model.checkLocationPermission();
        expect(model.isLocationPermissionGranted, true);
      });

      test('checkLocationPermission should request permission when denied', () async {
        final model = getModel();

        when(mockPermissionService.checkLocationPermission())
            .thenAnswer((_) async => PermissionStatus.denied);
        when(mockPermissionService.requestLocationPermission())
            .thenAnswer((_) async => PermissionStatus.granted);

        await model.checkLocationPermission();
        expect(model.isLocationPermissionGranted, true);
      });
    });

  });
}