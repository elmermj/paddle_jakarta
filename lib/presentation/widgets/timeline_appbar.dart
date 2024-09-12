import 'package:flutter/material.dart';
import 'package:paddle_jakarta/presentation/views/home/viewmodels/home_viewmodel.dart';
import 'package:paddle_jakarta/presentation/widgets/match_history_card_widget.dart';
import 'package:paddle_jakarta/presentation/widgets/timeline_category_item_widget.dart';
import 'package:paddle_jakarta/utils/tools/log.dart';

class TimelineAppBar extends AppBar {
  final MediaQueryData mediaQuery;
  final bool isLastMatchCardMinimized;
  final bool isLastMatchCardMinimizedFinalized;
  final Function onTap;
  final HomeViewModel viewModel;

  TimelineAppBar({
    super.key,
    required this.mediaQuery,
    required this.isLastMatchCardMinimized,
    required this.onTap,
    required this.viewModel, 
    required this.isLastMatchCardMinimizedFinalized,
  });
  
  @override
  Size get preferredSize {
    final double cardHeight = mediaQuery.size.width / (18 / 9) + 24;
    Log.green("App bar height : ${isLastMatchCardMinimizedFinalized ? kToolbarHeight : (mediaQuery.size.width / (18 / 9) + 24)}");
    return Size.fromHeight(isLastMatchCardMinimizedFinalized 
    ? kToolbarHeight : (cardHeight + 48 > 280 ? 280 : cardHeight + 48));
  }

  @override
  Widget get flexibleSpace {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
        constraints: BoxConstraints(
          maxHeight: isLastMatchCardMinimizedFinalized ? kToolbarHeight : (mediaQuery.size.width / (18 / 9) + 24),
        ),
        width: constraints.maxWidth > 480 ? 480 : constraints.maxWidth,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: AnimatedSwitcher(
                  duration: Durations.short3,
                  reverseDuration: Durations.short3,
                  transitionBuilder: _transitionBuilder,
                  child: isLastMatchCardMinimized
                    ? Row(
                        children: [
                          Flexible(
                            child: IntrinsicHeight(
                              child: TimelineCategoryItemWidget(viewModel: viewModel,),
                            ),
                          ),
                          Flexible(
                            child: IntrinsicHeight(
                              child: TimelineCategoryItemWidget(viewModel: viewModel,),
                            ),
                          ),
                          Flexible(
                            child: IntrinsicHeight(
                              child: TimelineCategoryItemWidget(viewModel: viewModel,),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: AnimatedSwitcher(
                  duration: Durations.short3,
                  reverseDuration: Durations.short3,
                  transitionBuilder: _transitionBuilder,
                  child: isLastMatchCardMinimized
                    ? const SizedBox.shrink()
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () => onTap(),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: SizedBox(
                              width: mediaQuery.size.width > 480 
                                    ? 480 : mediaQuery.size.width,
                              child: MatchHistoryCardWidget(
                                key: const ValueKey('matchHistoryCard'),
                                mediaQuery: mediaQuery,
                                isLast: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                ),
              ),
            ),
          ],
        ),
      );
      },
    );
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
