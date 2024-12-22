import 'package:flutter/material.dart';
import 'package:paddle_jakarta/presentation/views/home/viewmodels/home_viewmodel.dart';
import 'package:paddle_jakarta/presentation/widgets/match_history_card_widget.dart';
import 'package:paddle_jakarta/presentation/widgets/radar_chart_widget.dart';
import 'package:paddle_jakarta/presentation/widgets/speedometer_widget.dart';
import 'package:paddle_jakarta/presentation/widgets/timeline_category_item_widget.dart';
import 'package:paddle_jakarta/utils/tools/log.dart';

class TimelineAppBar extends StatelessWidget {
  final MediaQueryData mediaQuery;
  final bool isSpeedometerMinimizedFinalized;
  final bool isLastMatchCardMinimizedFinalized;
  final bool isRadarChartMinimizedFinalized;
  final HomeViewModel viewModel;
  final double height;

  const TimelineAppBar({
    super.key,
    required this.mediaQuery,
    required this.isSpeedometerMinimizedFinalized,
    required this.viewModel, 
    required this.height,
    required this.isLastMatchCardMinimizedFinalized,
    required this.isRadarChartMinimizedFinalized,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      transitionBuilder: _transitionBuilder,
      child: AnimatedContainer(
        key: ValueKey<double>(height),  // Unique key to trigger animation when height changes
        duration: const Duration(milliseconds: 150),
        width: mediaQuery.size.width > 480 ? 480 : mediaQuery.size.width,
        height: height,
        alignment: Alignment.topCenter,
        transformAlignment: Alignment.topCenter,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: isLastMatchCardMinimizedFinalized &&
                            isSpeedometerMinimizedFinalized &&
                            isRadarChartMinimizedFinalized
                        ? Row(
                            children: [
                              Flexible(
                                child: IntrinsicHeight(
                                  child: TimelineCategoryItemWidget(
                                    title: 'Match History',
                                    onTap: () => viewModel.toggleLastMatchCardMinimized(),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: IntrinsicHeight(
                                  child: TimelineCategoryItemWidget(
                                    title: 'Your rating',
                                    onTap: () => viewModel.toggleSpeedometerMinimized(),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: IntrinsicHeight(
                                  child: TimelineCategoryItemWidget(
                                    title: 'Your stats',
                                    onTap: () => viewModel.toggleRadarChartMinimized(),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 300),
                      transitionBuilder: _transitionBuilder,
                      child: _buildAppBarBody(viewModel),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBarBody(HomeViewModel viewModel) {
    if (!isLastMatchCardMinimizedFinalized) {
      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => viewModel.toggleLastMatchCardMinimized(),
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
      );
    }
    if (!isRadarChartMinimizedFinalized) {
      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => viewModel.toggleRadarChartMinimized(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: SizedBox(
            width: mediaQuery.size.width > 480
                  ? 480 : mediaQuery.size.width,
            child: RadarChartWidget(
              key: const ValueKey('radarChart'),
              values: const [0.8 , 0.45, 0.33, 0.96, 0.79, 0.8],
              height: height,
              labels: const [
                'Attack',
                'Defence',
                'Mobility',
                'Technique',
                'Tactics',
                'Overall',
              ],
            ),
          ),
        ),
      );
    }
    if (!isSpeedometerMinimizedFinalized) {
      return SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => viewModel.toggleSpeedometerMinimized(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: SizedBox(
            width: mediaQuery.size.width > 480 
                  ? 480 : mediaQuery.size.width,
            child: SpeedometerWidget(
              key: const ValueKey('speedometer'),
              height: 180,
              mediaQuery: mediaQuery,
              actualValue: 68.8,)
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _transitionBuilder(Widget child, Animation<double> animation) {
    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animation, curve: Curves.easeInOut),
    );

    final scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animation, curve: Curves.easeInOut),
    );

    return Align(
      alignment: Alignment.topCenter,
      child: ScaleTransition(
        alignment: Alignment.topCenter,
        scale: scaleAnimation,
        child: FadeTransition(
          opacity: fadeAnimation,
          child: child,
        ),
      ),
    );
  }
}