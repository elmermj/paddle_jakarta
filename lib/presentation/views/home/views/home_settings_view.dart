import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:paddle_jakarta/app/app.locator.dart';
import 'package:paddle_jakarta/data/models/user_model.dart';
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
              color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.surfaceBright.withOpacity(0.1),
                  blurRadius: 1.0,
                ),
              ],
            ),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 2 < 480
            ? MediaQuery.of(context).size.height / 2
            : 480,
            ),
            margin: const EdgeInsets.only(top: 24),
            child: AspectRatio(
              aspectRatio: 18/6,
              child: Stack(
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0.95, 0.85),
                    child: IconButton(
                      onPressed: (){}, 
                      icon: const Icon(LucideIcons.edit, size: 16,)
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              maxRadius: 48,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(48),
                                child: Image.network(
                                  locator<Box<UserModel>>().get('userData')?.photoUrl ?? 'https://i.pravatar.cc/300',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error); // Provide a fallback widget in case of an error
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  locator<Box<UserModel>>().get('userData')?.displayName ?? 'User',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  locator<Box<UserModel>>().get('userData')?.email ?? 'User',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            )
                          )
                        ]
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 2 < 480
                  ? MediaQuery.of(context).size.height / 2
                  : 480,
            ),
            child: ListView(
              shrinkWrap: true,
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
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(viewModel.isLocationPermissionGranted? 'Location On ': 'Location Off '))
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () async => await viewModel.checkLocationPermission(isTurnOff: viewModel.isLocationPermissionGranted),
                                icon: Icon(
                                  key: ValueKey<bool>(viewModel.isLocationPermissionGranted),
                                  viewModel.isLocationPermissionGranted
                                ? LucideIcons.locate
                                : LucideIcons.locateOff,
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
          ),
        )
      ],
    );
  }
}
