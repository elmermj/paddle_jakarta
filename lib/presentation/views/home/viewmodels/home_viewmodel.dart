import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paddle_jakarta/app/app.bottomsheets.dart';
import 'package:paddle_jakarta/app/app.dialogs.dart';
import 'package:paddle_jakarta/app/app.locator.dart';
import 'package:paddle_jakarta/app/app.router.dart';
import 'package:paddle_jakarta/data/models/timeline_item_model.dart';
import 'package:paddle_jakarta/domain/repository/timeline_repository.dart';
import 'package:paddle_jakarta/domain/repository/user_repository.dart';
import 'package:paddle_jakarta/presentation/common/app_strings.dart';
import 'package:paddle_jakarta/services/theme_service.dart';
import 'package:paddle_jakarta/utils/tools/log.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

part 'home_viewmodel_state.dart';
part 'home_viewmodel_functions.dart';

class HomeViewModel extends BaseViewModel {
  final GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;
  
  final UserRepository _userRepository;
  final TimelineRepository _timelineRepository;

  HomeViewModel(this._userRepository, this._timelineRepository);

  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _navigationService = locator<NavigationService>();
  final themeService = locator<ThemeService>();

  int indexState = 0;
  int limitLoad = 10;

  late bool isLocationPermissionGranted;

  bool isDeletingCache = false;
  bool isLastMatchCardMinimized = false;
  bool isLastMatchCardMinimizedFinalized = false;
  bool isAnimating = false;
  bool isNotificationUnseen = false;
  bool isEditingProfile = false;
  bool isTimelineLoading = false;
  double progress = 1.0;

  StreamSubscription<Position>? positionStreamSubscription;
  LatLng? currentPosition;
  ScrollController timelineScrollController = ScrollController();

  Set<TimelineItemModel> timelineItems = {};

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Stacked Rocks!',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: ksHomeBottomSheetTitle,
      description: ksHomeBottomSheetDescription,
    );
  }

  Future<void> init() async {
    await mapInit();
    await getMyTimeline();
    _initializeScrollListener();
  }

  Future<void> mapInit() async {
    await checkLocationPermission();
    Log.green('Location permission ::: $isLocationPermissionGranted');
    if (isLocationPermissionGranted) {
      _startListeningToLocationChanges();
    }
  }

  void _initializeScrollListener() {
    timelineScrollController.jumpTo(timelineScrollController.position.maxScrollExtent);
    timelineScrollController.addListener(() {
      Log.yellow("Current scroll position: ${timelineScrollController.position.pixels}");
      Log.yellow("Max scroll extent: ${timelineScrollController.position.maxScrollExtent}");

      if (timelineScrollController.position.pixels >=
          timelineScrollController.position.maxScrollExtent * 1.25) {
        if (!isTimelineLoading && timelineItems.isNotEmpty) {
          isTimelineLoading = true;
          loadMoreTimelineItems(timelineItems.last.timelineItemId!);
        }
      }
    });
  }

  @override
  void dispose() {
    timelineScrollController.dispose(); // Dispose the scroll controller
    positionStreamSubscription?.cancel();
    Log.red('HomeViewModel disposed');
    super.dispose();
  }

  final List<TimelineItemModel> dummyTimelineItems = [
  TimelineItemModel(
    timelineItemId: '1',
    title: 'Event 1',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '2',
    title: 'Event 2',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '3',
    title: 'Event 3',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '4',
    title: 'Event 4',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '5',
    title: 'Event 5',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '6',
    title: 'Event 6',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '7',
    title: 'Event 7',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '8',
    title: 'Event 8',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '9',
    title: 'Event 9',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '10',
    title: 'Event 10',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '11',
    title: 'Event 11',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '12',
    title: 'Event 12',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '13',
    title: 'Event 13',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '14',
    title: 'Event 14',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '15',
    title: 'Event 15',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '16',
    title: 'Event 16',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '17',
    title: 'Event 17',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '18',
    title: 'Event 18',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '19',
    title: 'Event 19',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
  TimelineItemModel(
    timelineItemId: '20',
    title: 'Event 20',
    type: 'event',
    timestamp: Timestamp.now(),
  ),
];

}


