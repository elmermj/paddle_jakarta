import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:paddle_jakarta/presentation/common/ui_helpers.dart';
import 'package:paddle_jakarta/presentation/views/home/viewmodels/home_viewmodel.dart';

class HomeSettingsView extends StatelessWidget {
  final HomeViewModel viewModel;
  const HomeSettingsView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
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
              maxHeight: MediaQuery.of(context).size.height / 5 < 240
                  ? MediaQuery.of(context).size.height / 5
                  : 240,
            ),
            margin: const EdgeInsets.all(8),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: const Text('Your last macth against player'),
                  ),
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Theme.of(context).elevatedButtonTheme.style?.minimumSize?.resolve({})?.height ?? 48,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.surfaceBright.withOpacity(0.1),
                      blurRadius: 1.0,
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedSwitcher(
                    duration: Durations.medium2,
                    reverseDuration: Durations.medium2,
                    transitionBuilder: (Widget child, Animation<double> animation) => ScaleTransition(scale: animation, child: child),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Clean Cache '),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IgnorePointer(
                              ignoring: viewModel.isDeletingCache,
                              child: IconButton(
                                onPressed: () => viewModel.clearCache(),
                                icon: viewModel.isDeletingCache
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: LinearProgressIndicator(
                                    value: viewModel.progress,
                                    color: Theme.of(context).colorScheme.primary,
                                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                                    backgroundColor: Colors.black.withOpacity(0.1),
                                  ),
                                )
                              : const Icon(
                                  LucideIcons.trash,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              verticalSpaceSmall,
              Container(
                height: Theme.of(context).elevatedButtonTheme.style?.minimumSize?.resolve({})?.height ?? 48,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.surfaceBright.withOpacity(0.1),
                      blurRadius: 1.0,
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedSwitcher(
                    duration: Durations.medium2,
                    transitionBuilder: (Widget child, Animation<double> animation) => ScaleTransition(scale: animation, child: child),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Brightness Mode '))
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () => viewModel.toggleTheme(),
                              icon: Icon(
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
              ),
              verticalSpaceMedium,
              ElevatedButton(
                  onPressed: () async => await viewModel.logout(),
                  child: const Text("Logout")),
            ],
          ),
        )
      ],
    );
  }
}
