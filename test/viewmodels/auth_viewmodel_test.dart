import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:paddle_jakarta/app/app.locator.dart';
import 'package:paddle_jakarta/presentation/views/auth/viewmodels/auth_viewmodel.dart';

import '../helpers/test_helpers.dart';
import '../helpers/test_helpers.mocks.dart';
import 'home_viewmodel_test.mocks.dart';

void main() {
  final mockUserRepository = MockUserRepository();  
  late AuthViewModel viewModel;
  late MockNavigationService mockNavigationService;
  group('viewModel Tests -', () {
    setUp(() {
      mockNavigationService = getAndRegisterNavigationService();
      registerServices();
      viewModel = AuthViewModel(mockUserRepository);
      viewModel.navigationService = mockNavigationService;
    });
    tearDown(() => locator.reset());

    test('initializeVariables should initialize all controllers', () {
      viewModel.initializeVariables(false);

      expect(viewModel.emailController, isNotNull);
      expect(viewModel.emailConfirmController, isNotNull);
      expect(viewModel.phoneNumberController, isNotNull);
      expect(viewModel.passwordController, isNotNull);
      expect(viewModel.passwordConfirmController, isNotNull);
      expect(viewModel.nameController, isNotNull);
    });

    test('initializeVariables should set loading states to false', () {
      viewModel.initializeVariables(false);

      expect(viewModel.isEmailCommitLoading, false);
      expect(viewModel.isGoogleLoginLoading, false);
      expect(viewModel.isLoading, false);
    });

    test('initializeVariables should set visibility states to false', () {
      viewModel.initializeVariables(false);

      expect(viewModel.isVisible, false);
      expect(viewModel.isConfirmVisible, false);
    });

    test('initializeVariables should set other boolean states to false', () {
      viewModel.initializeVariables(false);

      expect(viewModel.isBouncing, false);
      expect(viewModel.isForgotEmailSent, false);
    });

    test('initializeVariables should set indexState to 0 when fromForgot is true', () {
      viewModel.initializeVariables(true);

      expect(viewModel.indexState, 0);
    });

    test('initializeVariables should not change indexState when fromForgot is false', () {
      viewModel.indexState = 2;
      viewModel.initializeVariables(false);

      expect(viewModel.indexState, 2);
    });

    test('initializeVariables should clear existing text in controllers', () {
      viewModel.emailController = TextEditingController(text: 'test@example.com');
      viewModel.passwordController = TextEditingController(text: 'password123');

      viewModel.initializeVariables(false);

      expect(viewModel.emailController.text, isEmpty);
      expect(viewModel.passwordController.text, isEmpty);
    });

    test('initial visibility should be false', () {
      expect(viewModel.isVisible, isFalse);
    });

    test('toggleVisibility should change visibility state', () {
      viewModel.toggleVisibility();
      expect(viewModel.isVisible, isTrue);

      viewModel.toggleVisibility();
      expect(viewModel.isVisible, isFalse);
    });

    test('toggleVisibility should notify listeners', () {
      int notificationCount = 0;
      viewModel.addListener(() {
        notificationCount++;
      });

      viewModel.toggleVisibility();
      expect(notificationCount, 1);

      viewModel.toggleVisibility();
      expect(notificationCount, 2);
    });

    test('multiple toggles should alternate visibility state', () {
      for (int i = 0; i < 5; i++) {
        viewModel.toggleVisibility();
        expect(viewModel.isVisible, isTrue);

        viewModel.toggleVisibility();
        expect(viewModel.isVisible, isFalse);
      }
    });

    test('toggleConfirmVisibility changes isConfirmVisible', () {
      expect(viewModel.isConfirmVisible, isFalse);
      
      viewModel.toggleConfirmVisibility();
      expect(viewModel.isConfirmVisible, isTrue);
      
      viewModel.toggleConfirmVisibility();
      expect(viewModel.isConfirmVisible, isFalse);
    });

    test('toggleConfirmVisibility notifies listeners', () {
      int notificationCount = 0;
      viewModel.addListener(() {
        notificationCount++;
      });

      viewModel.toggleConfirmVisibility();
      expect(notificationCount, 1);

      viewModel.toggleConfirmVisibility();
      expect(notificationCount, 2);
    });

    test('forgotIconBounce toggles isBouncing', () {
      expect(viewModel.isBouncing, isFalse);
      
      viewModel.forgotIconBounce();
      expect(viewModel.isBouncing, isTrue);
      
      viewModel.forgotIconBounce();
      expect(viewModel.isBouncing, isFalse);
    });

    test('forgotIconBounce notifies listeners', () {
      int notificationCount = 0;
      viewModel.addListener(() {
        notificationCount++;
      });

      viewModel.forgotIconBounce();
      expect(notificationCount, 1);

      viewModel.forgotIconBounce();
      expect(notificationCount, 2);
    });

    test('forgotIconBounce is asynchronous', () async {
      expect(viewModel.forgotIconBounce(), isA<Future>());
    });

    test('multiple calls to forgotIconBounce toggle isBouncing correctly', () async {
      expect(viewModel.isBouncing, isFalse);
      
      await viewModel.forgotIconBounce();
      expect(viewModel.isBouncing, isTrue);
      
      await viewModel.forgotIconBounce();
      expect(viewModel.isBouncing, isFalse);
      
      await viewModel.forgotIconBounce();
      expect(viewModel.isBouncing, isTrue);
    });

    test('switchAuthState updates indexState and calls initializeVariables', () {
      viewModel.switchAuthState(index: 1);

      expect(viewModel.indexState, 1);
    });

    test('switchAuthState with different indices', () {
      viewModel.switchAuthState(index: 0);
      expect(viewModel.indexState, 0);

      viewModel.switchAuthState(index: 2);
      expect(viewModel.indexState, 2);

      viewModel.switchAuthState(index: -1);
      expect(viewModel.indexState, -1);
    });

    test('startCountdown should decrease countdown from 3 to 0', () async {
      viewModel.countdown = 3;
      await viewModel.startCountdown();
      await Future.delayed(const Duration(milliseconds: 3100));
      expect(viewModel.countdown, 0);
    });

    test('startCountdown should call navigationService.back() when countdown reaches 0', () async {
      viewModel.countdown = 1;
      await viewModel.startCountdown();
      await Future.delayed(const Duration(seconds: 2));
      verify(mockNavigationService.back()).called(1);
    });

    test('startCountdown should not call navigationService.back() when interrupted', () async {
      viewModel.countdown = 3;

      viewModel.startCountdown();
      await Future.delayed(const Duration(seconds: 1));
      mockNavigationService.back();
      
      await Future.delayed(const Duration(seconds: 1));

      expect(viewModel.countdown, 1);
    });

    test('startCountdown should notify listeners for each countdown decrement', () async {
      int notificationCount = 0;
      viewModel.addListener(() {
        notificationCount++;
      });

      viewModel.countdown = 3;
      await viewModel.startCountdown();
      await Future.delayed(const Duration(milliseconds: 3100));

      expect(notificationCount, 3);
    });

    test('startCountdown should handle countdown starting from 0', () async {
      viewModel.countdown = 0;
      await viewModel.startCountdown();
      verify(mockNavigationService.back()).called(1);
    });

    test('validateEmail should set error for invalid email', () {
      viewModel.emailController.text = 'invalid_email';
      viewModel.validateEmail();
      expect(viewModel.emailError.value, 'Please enter a valid email.');
    });

    test('validateEmail should clear error for valid email', () {
      viewModel.emailController.text = 'valid@email.com';
      viewModel.validateEmail();
      expect(viewModel.emailError.value, null);
    });

    test('validateEmailMatch should set error for mismatched emails', () {
      viewModel.emailController.text = 'email1@example.com';
      viewModel.emailConfirmController.text = 'email2@example.com';
      viewModel.validateEmailMatch();
      expect(viewModel.emailConfirmError.value, 'Emails do not match.');
    });

    test('validateEmailMatch should clear error for matching emails', () {
      viewModel.emailController.text = 'email@example.com';
      viewModel.emailConfirmController.text = 'email@example.com';
      viewModel.validateEmailMatch();
      expect(viewModel.emailConfirmError.value, null);
    });

    test('validatePassword should set error for short password', () {
      viewModel.passwordController.text = '1234567';
      viewModel.validatePassword();
      expect(viewModel.passwordError.value, 'Password must not be empty and be at least 8 characters.');
    });

    test('validatePassword should clear error for valid password', () {
      viewModel.passwordController.text = '12345678';
      viewModel.validatePassword();
      expect(viewModel.passwordError.value, null);
    });

    test('validatePasswordMatch should set error for mismatched passwords', () {
      viewModel.passwordController.text = 'password1';
      viewModel.passwordConfirmController.text = 'password2';
      viewModel.validatePasswordMatch();
      expect(viewModel.passwordConfirmError.value, 'Passwords do not match.');
    });

    test('validatePasswordMatch should clear error for matching passwords', () {
      viewModel.passwordController.text = 'password123';
      viewModel.passwordConfirmController.text = 'password123';
      viewModel.validatePasswordMatch();
      expect(viewModel.passwordConfirmError.value, null);
    });

    test('validatePhoneNumber should set error for empty phone number', () {
      viewModel.phoneNumberController.text = '';
      viewModel.validatePhoneNumber();
      expect(viewModel.phoneNumberError.value, 'Phone number is required.');
    });

    test('validatePhoneNumber should clear error for non-empty phone number', () {
      viewModel.phoneNumberController.text = '1234567890';
      viewModel.validatePhoneNumber();
      expect(viewModel.phoneNumberError.value, null);
    });

    test('validateName should set error for empty name', () {
      viewModel.nameController.text = '';
      viewModel.validateName();
      expect(viewModel.nameError.value, 'Please enter your name.');
    });

    test('validateName should clear error for non-empty name', () {
      viewModel.nameController.text = 'John Doe';
      viewModel.validateName();
      expect(viewModel.nameError.value, null);
    });

    test('isRegisterFormValid should return false when any field is invalid', () {
      viewModel.emailController.text = 'invalid_email';
      viewModel.emailConfirmController.text = 'valid@email.com';
      viewModel.passwordController.text = '1234567';
      viewModel.passwordConfirmController.text = '12345678';
      viewModel.nameController.text = '';
      viewModel.phoneNumberController.text = '';
      
      expect(viewModel.isRegisterFormValid(), false);
    });

    test('isRegisterFormValid should return true when all fields are valid', () {
      viewModel.emailController.text = 'valid@email.com';
      viewModel.emailConfirmController.text = 'valid@email.com';
      viewModel.passwordController.text = '12345678';
      viewModel.passwordConfirmController.text = '12345678';
      viewModel.nameController.text = 'John Doe';
      viewModel.phoneNumberController.text = '1234567890';
      
      expect(viewModel.isRegisterFormValid(), true);
    });

    test('isLoginFormValid should return false when email or password is invalid', () {
      viewModel.emailController.text = 'invalid_email';
      viewModel.passwordController.text = '1234567';
      
      expect(viewModel.isLoginFormValid(), false);
    });

    test('isLoginFormValid should return true when email and password are valid', () {
      viewModel.emailController.text = 'valid@email.com';
      viewModel.passwordController.text = '12345678';
      
      expect(viewModel.isLoginFormValid(), true);
    });

  });
}

