part of 'home_viewmodel.dart';

extension Functions on HomeViewModel {
  clearCache() {
    isDeletingCache = true;
    notifyListeners();

    const totalDuration = Duration(milliseconds: 4000);
    const stepInterval = Duration(milliseconds: 15);

    int elapsed = 0;

    Timer.periodic(stepInterval, (timer) {
      elapsed += stepInterval.inMilliseconds;

      double progressValue = 1 - (elapsed / totalDuration.inMilliseconds);
      updateProgress(progressValue);

      if (elapsed >= totalDuration.inMilliseconds) {
        timer.cancel();
        isDeletingCache = false;
        notifyListeners();
      }
    });
  }

  Future<void> logout() async {
    setBusy(true);

    final result = await _userRepository.logout();

    result.fold(
      (failure) {
        setBusy(false);
        _dialogService.showCustomDialog(
          variant: DialogType.infoAlert,
          title: 'Stacked Rocks!',
        );
      },
      (_) {
        setBusy(false);
        _navigationService.clearStackAndShow(Routes.authView);
      },
    );
  }

  Future<void> getMyTimeline() async {
    isTimelineLoading = true;
    notifyListeners();
    final result = await _timelineRepository.getMyTimelineItems(limitLoad);

    result.fold(
      (failure) {
        _dialogService.showCustomDialog(
          variant: DialogType.infoAlert,
          title: failure.toString(),
        );
      },
      (timelineItemsResponse) {
        for(var timelineItem in timelineItemsResponse) {
          Log.green('timelineItem: ${timelineItem.toJson()}');
        }
        timelineItems = timelineItemsResponse.toSet();
        notifyListeners();
      },
    );
    isTimelineLoading = false;
    notifyListeners();
  }

  Future<void> loadMoreTimelineItems(String timelineItemId) async {
    isTimelineLoading = true;
    notifyListeners();
    Log.yellow("Calling loadMoreTimelineItems");
    final result = await _timelineRepository.loadMoreTimelineItems(limitLoad, timelineItemId);
    result.fold(
      (failure) {
        _dialogService.showCustomDialog(
          variant: DialogType.infoAlert,
          title: failure.toString(),
        );
      },
      (timelineItemsResponse) {
        Log.green('timelineItemsResponse: $timelineItemsResponse');
        timelineItems.addAll(timelineItemsResponse);
        notifyListeners();
      },
    );
    isTimelineLoading = true;
    notifyListeners();
  }

  Future<void> checkLocationPermission({bool? isTurnOff}) async {
    PermissionStatus status = await Permission.location.status;

    if (status.isDenied) {
      status = await Permission.location.request();
    }

    if(isTurnOff == true && isTurnOff !=null) {
      status = PermissionStatus.denied;
    }
    isLocationPermissionGranted = status.isGranted;
    notifyListeners();
  }
}
