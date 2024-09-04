part of 'home_viewmodel.dart';

extension State on HomeViewModel {

  toggleTheme(){
    themeService.toggleTheme();
    notifyListeners();
  }

  void updateProgress(double newValue) {
    progress = newValue;
    notifyListeners();
  }

  switchHomeState({required int index}){
    if(positionStreamSubscription != null && index != 2){
      Log.yellow('Cancelling position stream subscription');
      positionStreamSubscription?.cancel();
    }
    indexState = index;
    notifyListeners();
  }

  void toggleLastMatchCardMinimized() {
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

}