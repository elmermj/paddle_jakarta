import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:paddle_jakarta/app/app.locator.dart';
import 'package:paddle_jakarta/domain/repository/timeline_repository.dart';
import 'package:paddle_jakarta/domain/repository/user_repository.dart';
import 'package:paddle_jakarta/presentation/views/home/views/home_create_match_screen.dart';
import 'package:paddle_jakarta/presentation/views/home/views/home_settings_view.dart';
import 'package:paddle_jakarta/presentation/views/home/views/home_timeline_view.dart';
import 'package:paddle_jakarta/presentation/widgets/nav_bar_item_widget.dart';
import 'package:paddle_jakarta/presentation/widgets/timeline_appbar.dart';
import 'package:paddle_jakarta/utils/themes/sporty_elegant_minimal_theme.dart';
import 'package:stacked/stacked.dart';

import '../viewmodels/home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: SportyElegantMinimalTheme.appBackgroundGradient(Theme.of(context).colorScheme.surfaceBright,),
        ),
        child: Scaffold(
          appBar: _buildAppBar(viewModel: viewModel, context: context),
          body: Center(child: _buildBody(viewModel: viewModel, context: context)),
          bottomNavigationBar: _buildNavBar(viewModel: viewModel, context: context)
        ),
      ),
    );
  }

  AppBar _buildAppBar({required HomeViewModel viewModel, required BuildContext context}) {
    
      switch (viewModel.indexState) {
        case 0:
          final mediaQuery = MediaQuery.of(context);
          return TimelineAppBar(
            mediaQuery: mediaQuery, 
            isLastMatchCardMinimized: viewModel.isLastMatchCardMinimized,
            isLastMatchCardMinimizedFinalized: viewModel.isLastMatchCardMinimizedFinalized,
            onTap: ()=>viewModel.toggleLastMatchCardMinimized(), 
            viewModel: viewModel
          );
        case 1:
          return AppBar(title: const Text('Leaderboard'));
        case 2:
          return AppBar(title: const Text('Create a match'));
        case 3:
          return AppBar(title: const Text('Profile'));
        case 4:
          return AppBar(title: const Text('Settings'));
        default:
          return AppBar(title: const Text('Home'));
    }
  }

  Widget _buildBody({required HomeViewModel viewModel, required BuildContext context}) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width < 480 ? MediaQuery.of(context).size.width : 480,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AnimatedSwitcher(
        duration: Durations.short3,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        child: Builder(
          key: ValueKey<int>(viewModel.indexState),
          builder: (context) {
            switch(viewModel.indexState) {
              case 0:
                return HomeTimelineView(viewModel: viewModel,);
              case 1:
                return Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height/5 < 240 ? MediaQuery.of(context).size.height/5 : 240,
                        ),
                        margin: const EdgeInsets.all(8),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: const Text('Your last match against player'),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              case 2:
                return HomeCreateMatchScreen(viewModel: viewModel);
              case 3:
                return Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height/5 < 240 ? MediaQuery.of(context).size.height/5 : 240,
                        ),
                        margin: const EdgeInsets.all(8),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                padding: const EdgeInsets.only(left: 8, top: 8),
                                child: const Text('Your last match against player'),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              case 4:
                return HomeSettingsView(viewModel: viewModel,);
              default:
                return const SizedBox();
            }
          }
        ),
      ),
    );
  }

  Container _buildNavBar({required HomeViewModel viewModel, required BuildContext context}) =>
  Container(
    width: double.infinity,
    height: kBottomNavigationBarHeight,
    padding: const EdgeInsets.all(8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NavBarItemWidget(index: 0, icon: LucideIcons.home, viewModel: viewModel),
        NavBarItemWidget(index: 1, icon: LucideIcons.award, viewModel: viewModel),
        NavBarItemWidget(index: 2, icon: LucideIcons.plus, viewModel: viewModel),
        NavBarItemWidget(index: 3, icon: LucideIcons.user, viewModel: viewModel),
        NavBarItemWidget(index: 4, icon: LucideIcons.settings, viewModel: viewModel),
      ],
    ),
  );

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) => HomeViewModel(locator<UserRepository>(), locator<TimelineRepository>());

  @override
  Future<void> onViewModelReady(HomeViewModel viewModel) async => await viewModel.init();

  Widget _transitionBuilder(Widget child, Animation<double> animation) {
    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animation, curve: Curves.easeInOut),
    );

    final scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animation, curve: Curves.easeInOut),
    );

    return ScaleTransition(
      alignment: Alignment.topCenter,
      scale: scaleAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: child,
      ),
    );
  }
}
