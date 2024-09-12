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

    return AnimatedSwitcher(
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
        key: ValueKey<bool>(viewModel.isLastMatchCardMinimized),
        builder: (context) {
          return viewModel.isLastMatchCardMinimized ? _buildChild(context) : _buildChild(context);
        }
      )
    );
  }

  Widget _buildChild(BuildContext context){
    return ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Row(
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
            reverse: true,
            physics: const ClampingScrollPhysics(),
            itemCount: viewModel.timelineItems.length,
            controller: viewModel.timelineScrollController,
            itemBuilder: (context, index) {
              return Container(
                constraints: const BoxConstraints(
                  maxHeight: 100,
                  minHeight: 25
                ),
                child: TimelineItemWidget(
                  timelineItem: viewModel.timelineItems.toList()[index],
                  isLast: viewModel.timelineItems.last == viewModel.timelineItems.toList()[index],
                  isFirst: viewModel.timelineItems.first == viewModel.timelineItems.toList()[index],
                ),
              );
            }
          ),
        ]
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
        controller: viewModel.timelineScrollController,
        itemBuilder: (context, index) {
          return Container(
            constraints: const BoxConstraints(
              maxHeight: 100,
              minHeight: 25
            ),
            child: TimelineItemWidget(
              timelineItem: viewModel.timelineItems.toList()[index],
              isLast: viewModel.timelineItems.last == viewModel.timelineItems.toList()[index],
              isFirst: viewModel.timelineItems.first == viewModel.timelineItems.toList()[index],
            ),
          );
        }
      ),
    ];
  }

  
}