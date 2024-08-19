import 'package:flutter/material.dart';
import 'package:paddle_jakarta/presentation/widgets/auth_form.dart';
import 'package:stacked/stacked.dart';

import 'auth_viewmodel.dart';

class AuthView extends StackedView<AuthViewModel> {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: _buildBody(viewModel: viewModel),
      bottomNavigationBar: _buildNavBar(viewModel, context)
    );
  }

  Container _buildBody({
    required AuthViewModel viewModel,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              ThemeData.light().primaryColor.toString(),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(0, -0.5),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () => viewModel.toggleTheme(),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Icon(
                  viewModel.themeService.isDarkMode
                ? Icons.dark_mode
                : Icons.light_mode,
                  key: ValueKey<bool>(viewModel.themeService.isDarkMode),
                  size: 64,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final slideTween = Tween<Offset>(
                  begin: viewModel.indexState == 0 ? const Offset(1, 0) : const Offset(-1, 0),
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
              child: AuthForm(
                viewModel: viewModel,
                index: viewModel.indexState,
                key: ValueKey<int>(viewModel.indexState),
              ),
            ),
          ),
        ],
      )
    );
  }

  Container _buildNavBar(AuthViewModel viewModel, BuildContext context) =>
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
  }) => Expanded(
    child: Center(
      child: TextButton(
        onPressed: () => viewModel.switchAuthState(index: index),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: index == viewModel.indexState ? FontWeight.bold : FontWeight.normal,
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
  ) => AuthViewModel();
}

