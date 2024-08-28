import 'package:flutter/material.dart';
import 'package:paddle_jakarta/presentation/views/home/viewmodels/home_viewmodel.dart';
import 'package:paddle_jakarta/presentation/widgets/match_history_card_widget.dart';
import 'package:paddle_jakarta/presentation/widgets/timeline_category_item_widget.dart';

class HomeTimelineView extends StatelessWidget {
  final HomeViewModel viewModel;
  const HomeTimelineView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: AnimatedSwitcher(
                duration: Durations.short3,
                reverseDuration: Durations.short3,
                transitionBuilder: (Widget child, Animation<double> animation) {
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
                },
                child: viewModel.isLastMatchCardMinimized? Row(
                  children: [
                    Expanded(
                      child: IntrinsicHeight(
                        child: TimelineCategoryItemWidget(viewModel: viewModel),
                      ),
                    ),
                    Expanded(
                      child: IntrinsicHeight(
                        child: TimelineCategoryItemWidget(viewModel: viewModel),
                      ),
                    ),
                    Expanded(
                      child: IntrinsicHeight(
                        child: TimelineCategoryItemWidget(viewModel: viewModel),
                      ),
                    ),
                  ],
                ): const SizedBox.shrink(),
              ),
            )
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => viewModel.toggleLastMatchCardMinimized(),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: AnimatedSwitcher(
                  duration: Durations.short3,
                  reverseDuration: Durations.short3,
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                    );
                
                    final scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                    );
                    return FadeTransition(
                      opacity: fadeAnimation,
                      child: ScaleTransition(
                        alignment: Alignment.topCenter,
                        scale: scaleAnimation,
                        child: child,
                      ),
                    );
                  },
                  child: viewModel.isLastMatchCardMinimized
                ? const SizedBox.shrink()
                : MatchHistoryCardWidget(
                    key: const ValueKey('matchHistoryCard'),
                    mediaQuery: mediaQuery,
                    isLast: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


