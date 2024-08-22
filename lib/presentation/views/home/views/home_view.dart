import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:paddle_jakarta/presentation/views/home/views/home_settings_view.dart';
import 'package:paddle_jakarta/presentation/views/home/views/home_timeline_view.dart';
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
          body: Center(child: _buildBody(viewModel: viewModel, context: context)),
          bottomNavigationBar: _buildNavBar(viewModel: viewModel, context: context)
        ),
      ),
    );
  }

  Widget _buildBody({required HomeViewModel viewModel, required BuildContext context}) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width < 480 ? MediaQuery.of(context).size.width : 480,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Builder(
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
        _buildNavBarItem(
          index: 0,
          icon: LucideIcons.home,
          viewModel: viewModel,
          context: context
        ),
        _buildNavBarItem(
          index: 1,
          icon: LucideIcons.award,
          viewModel: viewModel,
          context: context
        ),
        _buildNavBarItem(
          index: 2,
          icon: LucideIcons.plus,
          viewModel: viewModel,
          context: context
        ),
        _buildNavBarItem(
          index: 3,
          icon: LucideIcons.user,
          viewModel: viewModel,
          context: context
        ),
        _buildNavBarItem(
          index: 4,
          icon: LucideIcons.settings,
          viewModel: viewModel,
          context: context
        ),
      ],
    ),
  );

  Widget _buildNavBarItem({
    required int index,
    required IconData icon,
    required HomeViewModel viewModel,
    required BuildContext context
  }) =>
  Expanded(
    child: Center(
      child: IconButton(
        onPressed: () => viewModel.switchHomeState(index: index),
        style: TextButton.styleFrom(
          backgroundColor: index == viewModel.indexState
        ? Theme.of(context).colorScheme.surface.withOpacity(0.75)
        : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          )
        ),
        icon: Icon(
          icon,
          color: index == viewModel.indexState
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurface,
        )
      ),
    ),
  );

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) => HomeViewModel();
}



