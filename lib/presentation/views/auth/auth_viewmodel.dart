import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paddle_jakarta/app/app.locator.dart';
import 'package:paddle_jakarta/app/app.router.dart';
import 'package:paddle_jakarta/services/theme_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final themeService = locator<ThemeService>();

  TextEditingController emailController = TextEditingController();
  TextEditingController emailConfirmController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  int indexState = 0;

  int countdown = 5;

  bool isEmailCommitLoading = false;
  bool isGoogleLoginLoading = false;
  bool isVisible = false;
  bool isConfirmVisible = false;
  bool isBouncing = false;

  bool isForgotEmailSent = false;
  bool isLoading = false;

  initializeVariables(bool fromForgot) {
    emailController = TextEditingController();
    emailConfirmController = TextEditingController();
    phoneNumberController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    nameController = TextEditingController();
    isEmailCommitLoading = false;
    isGoogleLoginLoading = false;
    isVisible = false;
    isConfirmVisible = false;
    isBouncing = false;
    isForgotEmailSent = false;
    isLoading = false;
    if(fromForgot) {
      indexState = 0;
    }
  }

  Future<void> onLogin() async {
    isEmailCommitLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
    isEmailCommitLoading = false;
    notifyListeners();
  }

  Future<void> onRegister() async {}

  Future<void> onGoogleLogin() async {
    isGoogleLoginLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
    isGoogleLoginLoading = false;
    notifyListeners();
  }

  onForgotPassword() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3)).then((value) {
      isLoading = false;
      isForgotEmailSent = true;
      notifyListeners();
    });
    startCountdown();
  }

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
      if(countdown > 0){
        startCountdown();
      } else {        
        _navigationService.replaceWithAuthView();
      }
    });
  }

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    emailController.addListener(listener);
    passwordController.addListener(listener);
    emailConfirmController.addListener(listener);
    passwordConfirmController.addListener(listener);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailConfirmController.dispose();
    passwordConfirmController.dispose();
  }
}
