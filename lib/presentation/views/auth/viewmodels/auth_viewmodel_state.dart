part of 'auth_viewmodel.dart';

extension State on AuthViewModel {
  void toggleTheme() {
    themeService.toggleTheme();
    notifyListeners();
  }

  toggleVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }

  toggleConfirmVisibility() {
    isConfirmVisible = !isConfirmVisible;
    notifyListeners();
  }

  forgotIconBounce() async {
    isBouncing = !isBouncing;
    notifyListeners();
  }

  void switchAuthState({required int index}) {
    indexState = index;
    initializeVariables(false);
    notifyListeners();
  }

  startCountdown() async {
    await Future.delayed(const Duration(seconds: 1), () {
      countdown--;
      notifyListeners();
      if(navigationService.currentRoute == Routes.authView) {
        countdown = 0;
        return;
      }
      if(countdown > 0){
        startCountdown();
      } else {
        navigationService.back();
      }
    });
  }
}