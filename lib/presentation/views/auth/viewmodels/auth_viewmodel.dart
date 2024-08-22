import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paddle_jakarta/app/app.dialogs.dart';
import 'package:paddle_jakarta/app/app.locator.dart';
import 'package:paddle_jakarta/app/app.router.dart';
import 'package:paddle_jakarta/domain/use_cases/auth/forgot_password.dart';
import 'package:paddle_jakarta/domain/use_cases/auth/login_email.dart';
import 'package:paddle_jakarta/domain/use_cases/auth/login_google.dart';
import 'package:paddle_jakarta/domain/use_cases/auth/register_email.dart';
import 'package:paddle_jakarta/services/theme_service.dart';
import 'package:paddle_jakarta/utils/tools/log.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

part 'auth_viewmodel_form_validator.dart';
part 'auth_viewmodel_functions.dart';
part 'auth_viewmodel_state.dart';

class AuthViewModel extends BaseViewModel {

  final LoginEmail loginEmail;
  final LoginGoogle loginGoogle;
  final RegisterEmail registerEmail;
  final ForgotPassword forgotPassword;

  AuthViewModel(
    this.loginEmail,
    this.loginGoogle,
    this.registerEmail,
    this.forgotPassword
  );

  final navigationService = locator<NavigationService>();
  final themeService = locator<ThemeService>();
  final dialogService = locator<DialogService>();

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

  String forgotPasswordDetail = 'We have sent you an email with a link to reset your password';

  ValueNotifier<String?> emailError = ValueNotifier(null);
  ValueNotifier<String?> emailConfirmError = ValueNotifier(null);
  ValueNotifier<String?> passwordError = ValueNotifier(null);
  ValueNotifier<String?> passwordConfirmError = ValueNotifier(null);
  ValueNotifier<String?> nameError = ValueNotifier(null);

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

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    emailController.addListener(listener);
    passwordController.addListener(listener);
    emailConfirmController.addListener(listener);
    passwordConfirmController.addListener(listener);
    nameController.addListener(listener);
    phoneNumberController.addListener(listener);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailConfirmController.dispose();
    passwordConfirmController.dispose();
    emailError.dispose();
    emailConfirmError.dispose();
    passwordError.dispose();
    passwordConfirmError.dispose();
    nameError.dispose();
  }
}