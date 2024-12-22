import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:paddle_jakarta/app/app.locator.dart';
import 'package:paddle_jakarta/domain/repository/timeline_repository.dart';
import 'package:paddle_jakarta/domain/repository/user_repository.dart';
import 'package:paddle_jakarta/presentation/views/home/views/home_create_match_screen.dart';
import 'package:paddle_jakarta/presentation/views/home/views/home_settings_view.dart';
import 'package:paddle_jakarta/presentation/views/home/views/home_timeline_view.dart';
import 'package:paddle_jakarta/presentation/widgets/appbars/general_appbar.dart';
import 'package:paddle_jakarta/presentation/widgets/nav_bar_item_widget.dart';
import 'package:paddle_jakarta/presentation/widgets/timeline_appbar.dart';
import 'package:paddle_jakarta/services/permission_service.dart';
import 'package:paddle_jakarta/utils/themes/sporty_elegant_minimal_theme.dart';
import 'package:paddle_jakarta/utils/tools/log.dart';
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
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => viewModel.onBackButtonPressed(context),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: SportyElegantMinimalTheme.appBackgroundGradient(Theme.of(context).colorScheme.surfaceBright,),
          ),
          child: Scaffold(
            body: Stack(
              children: [
                Align(alignment: Alignment.topCenter, child: _buildAppBar(viewModel: viewModel, context: context)),
                AnimatedContainer(
                  duration: Durations.short3,
                  padding: EdgeInsets.only(top: (viewModel.isLastMatchCardMinimizedFinalized && viewModel.isSpeedometerMinimizedFinalized && viewModel.isRadarChartMinimizedFinalized) || viewModel.indexState != 0
            ? kToolbarHeight : (MediaQuery.of(context).size.width / (18 / 9) + 24)),
                  child: Center(child: _buildBody(viewModel: viewModel, context: context))
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _buildNavBar(viewModel: viewModel, context: context)
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar({required HomeViewModel viewModel, required BuildContext context}) {
    
      switch (viewModel.indexState) {
        case 0:
          final mediaQuery = MediaQuery.of(context);
          Log.yellow("isLastMatchCardMinimizedFinalized: ${viewModel.isLastMatchCardMinimizedFinalized}");
          Log.yellow("isSpeedometerMinimizedFinalized: ${viewModel.isSpeedometerMinimizedFinalized}");
          return TimelineAppBar(
            mediaQuery: mediaQuery,
            height: viewModel.isLastMatchCardMinimizedFinalized && viewModel.isSpeedometerMinimizedFinalized && viewModel.isRadarChartMinimizedFinalized
            ? kToolbarHeight : (mediaQuery.size.width / (18 / 9) + 24),
            isSpeedometerMinimizedFinalized: viewModel.isSpeedometerMinimizedFinalized,
            isLastMatchCardMinimizedFinalized: viewModel.isLastMatchCardMinimizedFinalized,
            isRadarChartMinimizedFinalized: viewModel.isRadarChartMinimizedFinalized,
            viewModel: viewModel
          );
        case 1:
          return const GeneralAppBar(title: "Leaderboard");
        case 2:
          return const GeneralAppBar(title: 'Create a match');
        case 3:
          return const GeneralAppBar(title: 'Profile');
        case 4:
          return const GeneralAppBar(title: 'Settings');
        default:
          return const GeneralAppBar(title: 'Home');
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
          return _transitionBuilder(child, animation);
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

  Widget _buildNavBar({required HomeViewModel viewModel, required BuildContext context}) {
    return AnimatedContainer(
      duration: Durations.medium1,
      width: viewModel.isLoading? 142 :
      viewModel.isCreateMatchScreenOpened 
          ? (MediaQuery.of(context).size.width / 3.5) * 2
          : MediaQuery.of(context).size.width,
      height: kBottomNavigationBarHeight - 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kBottomNavigationBarHeight),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 24.0, sigmaY: 24.0,
            tileMode: TileMode.mirror,
          ), // Adjust blur intensity
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(viewModel.isCreateMatchScreenOpened? 0.7 : 0.3), // Semi-transparent overlay
              borderRadius: BorderRadius.circular(kBottomNavigationBarHeight),
            ),
            child: AnimatedSwitcher(
              duration: Durations.short3,
              child: viewModel.isLoading?
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  key: const ValueKey('loading'), // Unique key for state differentiation
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Theme.of(context).colorScheme.onSurface,
                      strokeCap: StrokeCap.round,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      "Loading...",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    )
                  ]
                ),
              ):
              viewModel.isCreateMatchScreenOpened
            ? ListView(
                key: const ValueKey('createMatchRow'), 
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  InkWell(
                    onTap: () => viewModel.toggleCreateMatchBottomNavbar(),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: const Center(
                        child: Text("Cancel"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => viewModel.toggleCreateMatchBottomNavbar(),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: const Center(
                        child: Text("Create"),
                      ),
                    ),
                  ),
                ],
              )
            : ListView(
                key: const ValueKey('navBarRow'), // Unique key for state differentiation
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  NavBarItemWidget(index: 0, icon: LucideIcons.home, viewModel: viewModel, width: (MediaQuery.of(context).size.width -48) / 5,),
                  NavBarItemWidget(index: 1, icon: LucideIcons.award, viewModel: viewModel, width: (MediaQuery.of(context).size.width -48) / 5,),
                  NavBarItemWidget(index: 2, icon: LucideIcons.plus, viewModel: viewModel, width: (MediaQuery.of(context).size.width -48) / 5,),
                  NavBarItemWidget(index: 3, icon: LucideIcons.user, viewModel: viewModel, width: (MediaQuery.of(context).size.width -48) / 5,),
                  NavBarItemWidget(index: 4, icon: LucideIcons.settings, viewModel: viewModel, width: (MediaQuery.of(context).size.width -48) / 5,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) => HomeViewModel(locator<UserRepository>(), locator<TimelineRepository>(), PermissionService());

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