import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:paddle_jakarta/presentation/common/ui_helpers.dart';
import 'package:paddle_jakarta/presentation/views/home/viewmodels/home_viewmodel.dart';
import 'package:paddle_jakarta/presentation/widgets/timeline_item_widget.dart';

class HomeTimelineView extends StatelessWidget {
  final HomeViewModel viewModel;
  const HomeTimelineView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return _buildChild(context);
  }

  Widget _buildChild(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IntrinsicHeight(
                child: Text(
                  'Timeline',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              IntrinsicHeight(
                child: IconButton(
                  onPressed: () {},
                  icon: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(LucideIcons.bell),
                      viewModel.isNotificationUnseen
                          ? const Positioned(
                              top: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 4,
                                backgroundColor: Colors.red,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SliverToBoxAdapter(child: verticalSpaceMedium,),
        SliverFillRemaining(
          hasScrollBody: true,
          child: Align(
            alignment: Alignment.topCenter,
            child: AnimatedSwitcher(
              duration: Durations.short3,
              reverseDuration: Durations.short3,
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
                key: ValueKey<bool>(viewModel.isTimelineLoading),
                builder: (context) {
                  return viewModel.isTimelineLoading
                ? const SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                        verticalSpaceMedium,
                        Text(
                          'Loading timeline...',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight + 16),
                    physics: const BouncingScrollPhysics(),
                    itemCount: viewModel.dummyTimelineItems.length,
                    controller: viewModel.timelineScrollController,
                    itemBuilder: (context, index) {
                      return Container(
                        constraints: const BoxConstraints(
                          maxHeight: 100,
                          minHeight: 25,
                        ),
                        child: TimelineItemWidget(
                          timelineItem: viewModel.dummyTimelineItems.toList()[index],
                          isLast: viewModel.dummyTimelineItems.last == viewModel.dummyTimelineItems.toList()[index],
                          isFirst: viewModel.dummyTimelineItems.first == viewModel.dummyTimelineItems.toList()[index],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: kBottomNavigationBarHeight + 32),),
      ],
    );
  }
}