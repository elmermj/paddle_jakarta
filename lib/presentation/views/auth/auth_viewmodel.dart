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

  void switchAuthState({required int index}) {
    indexState = index;
    notifyListeners();
  }

  Future<void> onLogin() async {
    _navigationService.replaceWithHomeView();
  }

  Future<void> onRegister() async {
    _navigationService.replaceWithHomeView();
  }

  void toggleTheme() {
    themeService.toggleTheme();
    notifyListeners();
  }
}
