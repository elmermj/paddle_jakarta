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
    indexState = index;
    notifyListeners();
  }

  // void toggleLastMatchCardMinimized() {
  //   isAnimating = true; // Set to true to indicate animation is in progress
  //   notifyListeners();
    
  //   // Perform the transition animation, then set _isAnimating to false
  //   Future.delayed(Durations.short3, () {
  //     isLastMatchCardMinimized = !isLastMatchCardMinimized;
  //     isAnimating = false; // Set to false once animation is complete
  //     notifyListeners();
  //   });
  // }

  void toggleLastMatchCardMinimized() {
    isLastMatchCardMinimized = !isLastMatchCardMinimized;
    notifyListeners();
  }

  void toggleEditProfile(){
    isEditingProfile = !isEditingProfile;
    notifyListeners();
  }

}