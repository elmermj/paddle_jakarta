part of 'auth_viewmodel.dart';

extension FormValidator on AuthViewModel {
  
  void validateEmail() {
    if (emailController.text.isEmpty || !emailController.text.contains('@')) {
      emailError.value = 'Please enter a valid email.';
    } else {
      emailError.value = null;
    }
  }

  void validateEmailMatch() {
    if (emailConfirmController.text != emailController.text || emailConfirmController.text.isEmpty) {
      emailConfirmError.value = 'Emails do not match.';
    } else {
      emailConfirmError.value = null;
    }
  }

  void validatePassword() {
    if (passwordController.text.length < 8) {
      passwordError.value = 'Password must not be empty and be at least 8 characters.';
    } else {
      passwordError.value = null;
    }
  }

  void validatePasswordMatch() {
    if (passwordConfirmController.text != passwordController.text || passwordConfirmController.text.isEmpty) {
      passwordConfirmError.value = 'Passwords do not match.';
    } else {
      passwordConfirmError.value = null;
    }
  }

  void validatePhoneNumber(){
    if(phoneNumberController.text.isEmpty){
      phoneNumberError.value = 'Phone number is required.';
    } else {
      phoneNumberError.value = null;
    }
  }

  void validateName() {
    if (nameController.text.isEmpty) {
      nameError.value = 'Please enter your name.';
    } else {
      nameError.value = null;
    }
  }
  
  bool isRegisterFormValid() {
    validateEmail();
    validateEmailMatch();
    validatePassword();
    validatePasswordMatch();
    validateName();
    validatePhoneNumber();
    return emailError.value == null &&
        emailConfirmError.value == null &&
        passwordError.value == null &&
        passwordConfirmError.value == null &&
        nameError.value == null;
  }

  bool isLoginFormValid(){
    validateEmail();
    validatePassword();
    return emailError.value == null &&
        passwordError.value == null;
  }

}
