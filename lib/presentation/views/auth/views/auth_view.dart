import 'package:flutter/material.dart';
import 'package:paddle_jakarta/app/app.locator.dart';
import 'package:paddle_jakarta/domain/repository/user_repository.dart';
import 'package:paddle_jakarta/presentation/common/ui_helpers.dart';
import 'package:paddle_jakarta/presentation/widgets/auth_form.dart';
import 'package:paddle_jakarta/utils/themes/sporty_elegant_minimal_theme.dart';
import 'package:stacked/stacked.dart';

import '../viewmodels/auth_viewmodel.dart';

class AuthView extends StackedView<AuthViewModel> {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: SportyElegantMinimalTheme.appBackgroundGradient(Theme.of(context).colorScheme.surfaceBright,),
        ),
        child: Scaffold(
          body: Center(child: _buildBody(viewModel: viewModel, context: context)),
          bottomNavigationBar: _buildNavBar(viewModel: viewModel, context: context)
        ),
      ),
    );
  }

  Container _buildBody({required AuthViewModel viewModel, required BuildContext context}) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width < 480 ? MediaQuery.of(context).size.width : 480,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        children: [
          Align(
            alignment: const AlignmentDirectional(0, -0.5),
            child: AnimatedSwitcher(
              duration: Durations.medium2,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: MediaQuery.of(context).viewInsets.bottom != 0
              ? const SizedBox.shrink()
              : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Padel Jakarta', style: Theme.of(context).textTheme.headlineLarge),
                  verticalSpaceMedium,
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () => viewModel.toggleTheme(),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 150),
                        transitionBuilder: (Widget child, Animation<double> animation) => ScaleTransition(scale: animation, child: child),
                        child: Icon(
                          viewModel.themeService.isDarkMode
                        ? Icons.dark_mode
                        : Icons.light_mode,
                          key: ValueKey<bool>(viewModel.themeService.isDarkMode),
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width < 480 ? MediaQuery.of(context).size.width : 480,
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                reverseDuration: const Duration(milliseconds: 50),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  final slideTween = Tween<Offset>(
                    begin: viewModel.indexState == 0
                  ? const Offset(1, 0)
                  : const Offset(-1, 0),
                    end: Offset.zero,
                  );
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    ),
                    child: SlideTransition(
                      position: slideTween.animate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeInOut,
                        )
                      ),
                      child: child,
                    ),
                  );
                },
                child: GestureDetector(
                  // swipe left or right to switch between login and register
                  onHorizontalDragUpdate: (details) {
                    if (details.delta.dx > 0) {
                      viewModel.switchAuthState(index: 0);
                    } else if (details.delta.dx < 0) {
                      viewModel.switchAuthState(index: 1);
                    }
                  },
                  child: AuthForm(
                    suffixIcons: [
                      IconButton(
                        icon: Icon(
                          viewModel.isVisible
                        ? Icons.visibility
                        : Icons.visibility_off
                        ),
                        onPressed: () => viewModel.toggleVisibility(),
                      ),
                      IconButton(
                        icon: Icon(
                          viewModel.isConfirmVisible
                        ? Icons.visibility
                        : Icons.visibility_off
                        ),
                        onPressed: () => viewModel.toggleConfirmVisibility(),
                      ),
                    ],
                    isPasswords: [
                      viewModel.isVisible,
                      viewModel.isConfirmVisible
                    ],
                    viewModel: viewModel,
                    index: viewModel.indexState,
                    key: ValueKey<int>(viewModel.indexState),
                    emailLoginWidget: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) => ScaleTransition(scale: animation, child: child),
                      child: viewModel.isEmailCommitLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => viewModel.onLogin(
                          viewModel.emailController.text,
                          viewModel.passwordController.text,
                          false
                        ),
                        child: const Text('Login'),
                      ),
                    ),
                    emailRegisterWidget: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) => ScaleTransition(scale: animation, child: child),
                      child: viewModel.isEmailCommitLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => viewModel.onRegister(),
                        child: const Text('Register'),
                      ),
                    ),
                    googleLoginWidget: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (Widget child, Animation<double> animation) => ScaleTransition(scale: animation, child: child),
                      child: viewModel.isGoogleLoginLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => viewModel.onGoogleLogin(),
                        child: const Text('Login with Google'),
                      )
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  Container _buildNavBar({required AuthViewModel viewModel, required BuildContext context}) =>
  Container(
    width: double.infinity,
    height: kBottomNavigationBarHeight,
    padding: const EdgeInsets.all(8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildNavBarItem(
          index: 0,
          title: 'Login',
          viewModel: viewModel,
          context: context
        ),
        _buildNavBarItem(
          index: 1,
          title: 'Register',
          viewModel: viewModel,
          context: context
        ),
      ],
    ),
  );

  Widget _buildNavBarItem({
    required int index,
    required String title,
    required AuthViewModel viewModel,
    required BuildContext context
  }) =>
  Expanded(
    child: Center(
      child: TextButton(
        onPressed: () => viewModel.switchAuthState(index: index),
        style: TextButton.styleFrom(
          backgroundColor: index == viewModel.indexState
        ? Theme.of(context).colorScheme.surface.withOpacity(0.75)
        : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          )
        ),
        child: Text(
          title,
          style: TextStyle(
            color: index == viewModel.indexState
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    ),
  );

  @override
  AuthViewModel viewModelBuilder(
    BuildContext context,
  ) {
    return AuthViewModel(
      locator<UserRepository>(),
    );
  }
}
