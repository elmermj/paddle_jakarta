part of 'auth_viewmodel.dart';

extension Functions on AuthViewModel {

  Future<void> onLogin(String email, String password, bool fromRegister) async {
    isEmailCommitLoading = true;
    notifyListeners();
    if(!isLoginFormValid()){
      isEmailCommitLoading = false;
      notifyListeners();
      return;
    }

    final result = await loginEmail(email, password);
    result.fold(
      (failure) {
        isEmailCommitLoading = false;
        notifyListeners();
        fromRegister
      ? dialogService.showCustomDialog(
          variant: DialogType.infoAlert,
          title: failure,
          description: 'Re-enter your email and password',
        )
      : dialogService.showCustomDialog(
          variant: DialogType.infoAlert,
          title: failure,
        );
      },
      (_) {
        isEmailCommitLoading = false;
        notifyListeners();
        navigationService.clearStackAndShow(Routes.homeView);
      },
    );
  }

  Future<void> onRegister() async {
    isEmailCommitLoading = true;
    notifyListeners();
    if(!isRegisterFormValid()){
      isEmailCommitLoading = false;
      notifyListeners();
      return;
    }
    final result = await registerEmail(emailController.text, passwordController.text, nameController.text);
    result.fold(
      (failure) {
        isEmailCommitLoading = false;
        notifyListeners();
      },
      (_) async {
        isEmailCommitLoading = false;
        notifyListeners();
        await onLogin( 
          emailController.text,
          passwordController.text,
          true,
        );
      },
    );
  }

  Future<void> onGoogleLogin() async {
    isGoogleLoginLoading = true;
    notifyListeners();
    final result = await loginGoogle();
    result.fold(
      (failure){
        isGoogleLoginLoading = false;
        notifyListeners();
        locator<DialogService>().showDialog(
          title: failure.contains('Exception')? 'Exception' : 'Error',
          //only displays after 'Exception:'
          description: failure.contains('Exception:')? failure.split('Exception:')[1] : failure,
        );
      }, 
      (user){
        isGoogleLoginLoading = false;
        notifyListeners();
        navigationService.replaceWithHomeView();
      }
    );
  }

  onForgotPassword() async {
    isLoading = true;
    notifyListeners();
    final result = await forgotPassword(emailController.text);
    result.fold(
      (failure){
        Log.red("Failed to send email: $failure");
        forgotPasswordDetail = failure;
        Log.pink(forgotPasswordDetail);
        isLoading = false;
        isForgotEmailSent = true;
        notifyListeners();
        startCountdown();
      },
      (unit){
        isLoading = false;
        isForgotEmailSent = true;
        notifyListeners();
        startCountdown();
      }
    );
  }
}