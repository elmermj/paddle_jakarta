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
  
}