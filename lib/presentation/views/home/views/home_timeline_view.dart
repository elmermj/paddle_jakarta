import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:paddle_jakarta/presentation/common/ui_helpers.dart';
import 'package:paddle_jakarta/presentation/views/home/viewmodels/home_viewmodel.dart';
import 'package:paddle_jakarta/presentation/widgets/match_history_card_widget.dart';
import 'package:paddle_jakarta/presentation/widgets/timeline_category_item_widget.dart';
import 'package:paddle_jakarta/presentation/widgets/timeline_item_widget.dart';

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
                transitionBuilder: _transitionBuilder,
                child: viewModel.isLastMatchCardMinimized? ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
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
                    ),
                    ..._buildTimelineBody(context)
                  ],
                ): const SizedBox.shrink(),
              ),
            )
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: AnimatedSwitcher(
                duration: Durations.short3,
                reverseDuration: Durations.short3,
                transitionBuilder: _transitionBuilder,
                child: viewModel.isLastMatchCardMinimized
              ? const SizedBox.shrink()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => viewModel.toggleLastMatchCardMinimized(),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      child: MatchHistoryCardWidget(
                        key: const ValueKey('matchHistoryCard'),
                        mediaQuery: mediaQuery,
                        isLast: true,
                      ),
                    ),
                    ..._buildTimelineBody(context)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTimelineBody(BuildContext context){
    return [
      verticalSpaceMedium,
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IntrinsicHeight(
            child: Text(
              'Timeline',
              style: Theme.of(context).textTheme.titleLarge,
            )
          ),
          IntrinsicHeight(
            child: IconButton(
              onPressed: (){}, 
              icon: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    LucideIcons.bell,
                  ),
                  viewModel.isNotificationUnseen? const Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.red,
                    ),
                  ): const SizedBox.shrink()
                ],
              )
            ),
          ),
        ],
      ),
      verticalSpaceMedium,
      ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        reverse: true,
        itemCount: viewModel.timelineItems.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 100,
            child: TimelineItemWidget(
              timelineItem: viewModel.timelineItems[index],
              isLast: viewModel.timelineItems.last == viewModel.timelineItems[index],
              isFirst: viewModel.timelineItems.first == viewModel.timelineItems[index],
            ),
          );
        }
      )
    ];
  }

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