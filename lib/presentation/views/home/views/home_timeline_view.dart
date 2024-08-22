import 'package:flutter/material.dart';
import 'package:paddle_jakarta/presentation/views/home/viewmodels/home_viewmodel.dart';
import 'package:paddle_jakarta/presentation/widgets/match_history_card_widget.dart';
import 'package:paddle_jakarta/presentation/widgets/minimize_widget.dart';

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
            child: MinimizeWidget(
              onTap: ()=> viewModel.toggleLastMatchCardMinimized(),
              isMinimize: viewModel.isLastMatchCardMinimized,
              minimizedChild: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.surfaceBright,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceBright,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.05),
                      width: 1,
                    ),
                  ),
                  margin: const EdgeInsets.only(top: 24),
                  child: Text(
                    'Match History',
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ),
              ),
              child: MatchHistoryCardWidget(
                mediaQuery: mediaQuery, 
                isLast: true,
              )
            ),
          ),
        ],
      ),
    );
  }
}

