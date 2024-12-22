import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paddle_jakarta/app/app.dialogs.dart';
import 'package:paddle_jakarta/app/app.locator.dart';
import 'package:paddle_jakarta/app/app.router.dart';
import 'package:paddle_jakarta/data/models/timeline_item_model.dart';
import 'package:paddle_jakarta/domain/repository/timeline_repository.dart';
import 'package:paddle_jakarta/domain/repository/user_repository.dart';
import 'package:paddle_jakarta/presentation/widgets/dialogs/prompt_dialog.dart';
import 'package:paddle_jakarta/services/permission_service.dart';
import 'package:paddle_jakarta/services/theme_service.dart';
import 'package:paddle_jakarta/utils/dummy/dummy_timeline_items.dart';
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
  final PermissionService _permissionService;

  HomeViewModel(this._userRepository, this._timelineRepository, this._permissionService);

  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();
  ThemeService themeService = locator<ThemeService>();

  int indexState = 0;
  int previousIndexState = 0;
  int limitLoad = 10;

  late bool isLocationPermissionGranted;

  bool isDeletingCache = false;
  bool isLastMatchCardMinimized = false;
  bool isLastMatchCardMinimizedFinalized = false;
  bool isSpeedometerMinimized = false;
  bool isSpeedometerMinimizedFinalized = false;
  bool isRadarChartMinimized = false;
  bool isRadarChartMinimizedFinalized = false;
  bool timelineBodySwitch = false;
  bool isAnimating = false;
  bool isNotificationUnseen = false;
  bool isEditingProfile = false;
  bool isTimelineLoading = false;
  bool isCreateMatchScreenOpened = false;

  bool isLoading = false;
  
  double progress = 1.0;
  double appBarHeight = 0.0;

  StreamSubscription<Position>? positionStreamSubscription;
  LatLng? currentPosition;
  ScrollController timelineScrollController = ScrollController();
  final timelineAppBarKey = GlobalKey();

  Set<TimelineItemModel> timelineItems = {};

  Future<void> init() async {
    await mapInit();
    await getMyTimeline();
    _initializeScrollListener();
    jumpToMinOffset();
  }

  Future<void> mapInit() async {
    await checkLocationPermission();
    Log.green('Location permission ::: $isLocationPermissionGranted');
    if (isLocationPermissionGranted) {
      _startListeningToLocationChanges();
    }
  }

  void _initializeScrollListener() {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (timelineScrollController.hasClients) {
        // Ensure we only set up the listener if the controller has clients
        timelineScrollController.jumpTo(timelineScrollController.position.maxScrollExtent);

        timelineScrollController.addListener(() {
          // Ensure the controller is not null and has clients
          if (!timelineScrollController.hasClients) return;

          final position = timelineScrollController.position;
          Log.yellow("Current scroll position: ${position.pixels}");
          Log.yellow("Max scroll extent: ${position.maxScrollExtent}");

          // Check if we're at the top and trigger load more if conditions are met
          if (position.pixels <= position.minScrollExtent + 1 && !isTimelineLoading && timelineItems.isNotEmpty) {
            loadMoreTimelineItems("0");
          }
        });
      }
    });
  }

  @override
  void dispose() {
    timelineScrollController.dispose();
    positionStreamSubscription?.cancel();
    Log.red('HomeViewModel disposed');
    super.dispose();
  }


  //dummy data
  final List<TimelineItemModel> dummyTimelineItems = dummyTimelineItemsFile;

}


