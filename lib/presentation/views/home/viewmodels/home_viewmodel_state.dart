part of 'home_viewmodel.dart';

extension State on HomeViewModel {

  void jumpToMinOffset() {
    timelineScrollController.animateTo(-kToolbarHeight, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
  toggleTheme(){
    themeService.toggleTheme();
    notifyListeners();
  }

  void updateProgress(double newValue) {
    progress = newValue;
    notifyListeners();
  }

  switchHomeState({required int index}) async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(Durations.extralong4);
    isLoading = false;
    notifyListeners();
    if(positionStreamSubscription != null && index != 2){
      Log.yellow('Cancelling position stream subscription');
      positionStreamSubscription?.cancel();
    }
    if(index == 2){
      toggleCreateMatchBottomNavbar();
    }
    indexState = index;
    notifyListeners();
  }

  void toggleLastMatchCardMinimized() {
    timelineBodySwitch = true;
    notifyListeners();
    if(isLastMatchCardMinimized){
      isLastMatchCardMinimizedFinalized = !isLastMatchCardMinimizedFinalized;
      notifyListeners();
      Future.delayed(Durations.short1, () {
        isLastMatchCardMinimized = !isLastMatchCardMinimized;
        notifyListeners();
      });
    } else {
      isLastMatchCardMinimized = !isLastMatchCardMinimized;
      notifyListeners();
      Future.delayed(Durations.short3, () {
        isLastMatchCardMinimizedFinalized = !isLastMatchCardMinimizedFinalized;
        notifyListeners();
      });
    }
    timelineBodySwitch = false;
    notifyListeners();
  }

  void toggleSpeedometerMinimized(){
    timelineBodySwitch = true;
    notifyListeners();
    if(isSpeedometerMinimized){
      isSpeedometerMinimizedFinalized = !isSpeedometerMinimizedFinalized;
      notifyListeners();
      Future.delayed(Durations.short1, () {
        isSpeedometerMinimized = !isSpeedometerMinimized;
        notifyListeners();
      });
    } else {
      isSpeedometerMinimized = !isSpeedometerMinimized;
      notifyListeners();
      Future.delayed(Durations.short3, () {
        isSpeedometerMinimizedFinalized = !isSpeedometerMinimizedFinalized;
        notifyListeners();
      });
    }
    timelineBodySwitch = false;
    notifyListeners();
  }

  void toggleRadarChartMinimized(){
    timelineBodySwitch = true;
    notifyListeners();
    if(isRadarChartMinimized){
      isRadarChartMinimizedFinalized = !isRadarChartMinimizedFinalized;
      notifyListeners();
      Future.delayed(Durations.short1, () {
        isRadarChartMinimized = !isRadarChartMinimized;
        notifyListeners();
      });
    } else {
      isRadarChartMinimized = !isRadarChartMinimized;
      notifyListeners();
      Future.delayed(Durations.short3, () {
        isRadarChartMinimizedFinalized = !isRadarChartMinimizedFinalized;
        notifyListeners();
      });
    }
    timelineBodySwitch = false;
    notifyListeners();
  }

  void toggleEditProfile(){
    isEditingProfile = !isEditingProfile;
    notifyListeners();
  }

  void _startListeningToLocationChanges() {
    positionStreamSubscription =
        _geolocator.getPositionStream(locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 5,
        )).listen((Position position) {
          currentPosition = LatLng(position.latitude, position.longitude);
          Log.yellow('Current position: $currentPosition');
          notifyListeners(); 
        });
  }

  void updateCameraPosition(GoogleMapController controller){
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: currentPosition!,
          zoom: 16,
        ),
      ),
    );
    notifyListeners();
  }

  void toggleCreateMatchBottomNavbar(){
    if(isCreateMatchScreenOpened){
      switchHomeState(index: previousIndexState);
    }
    previousIndexState = indexState;
    isCreateMatchScreenOpened = !isCreateMatchScreenOpened;
    Log.yellow('isCreateMatchScreenOpened: $isCreateMatchScreenOpened');
    notifyListeners();
  }

  void onBackButtonPressed(BuildContext context){
    if(indexState==0){
      //exit application
      showDialog(
        context: context, 
        builder: (context) => PromptDialog(
          title: "Confirm Exit?", 
          message: "Are you sure you want to exit the application?",
          onConfirm: () => exit(0),
          onCancel: () => Navigator.pop(context),
          confirmText: "Exit",
          cancelText: "Cancel",
        )
      );
    } else {
      isCreateMatchScreenOpened = false;
      switchHomeState(index: 0);
    }
  }

}