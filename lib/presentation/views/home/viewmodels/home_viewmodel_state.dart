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

  toggleLastMatchCardMinimized() {
    isLastMatchCardMinimized = !isLastMatchCardMinimized; // Update the actual state variable
    notifyListeners();
  }
  
}