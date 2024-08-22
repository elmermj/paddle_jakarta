import 'package:flutter/material.dart';
import 'package:paddle_jakarta/presentation/widgets/score_widget.dart';
import 'package:paddle_jakarta/presentation/widgets/trapezoidal_widget.dart';

class MatchHistoryCardWidget extends StatefulWidget {
  const MatchHistoryCardWidget({
    super.key,
    required this.mediaQuery, required this.isLast,
  });

  final MediaQueryData mediaQuery;
  final bool isLast;

  @override
  State<MatchHistoryCardWidget> createState() => _MatchHistoryCardWidgetState();
}

class _MatchHistoryCardWidgetState extends State<MatchHistoryCardWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    if(widget.isLast) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500),
      )..repeat(reverse: true);
      _animation = Tween<double>(begin: 0.25, end: 0.75).animate(_controller);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.isLast) {
      return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceBright,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.05),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(_animation.value),
                  blurRadius: 8,
                  spreadRadius: 1 + _animation.value * 2,
                  offset: const Offset(-4, 4),
                ),
                BoxShadow(
                  color: Colors.red.withOpacity(_animation.value),
                  blurRadius: 8,
                  spreadRadius: 1 + _animation.value * 2,
                  offset: const Offset(4, -4),
                ),
              ],
            ),
            margin: const EdgeInsets.only(top: 24),
            child: AspectRatio(
              aspectRatio: 18 / 9,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Your last match against Player',
                        style: TextStyle(
                          fontSize: widget.mediaQuery.size.width > 420 ? 16 : 12,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1, -0.6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: widget.mediaQuery.size.width > 480 ? 480 * 0.48 : widget.mediaQuery.size.width * 0.48,
                          child: const TrapezoidalWidget(
                            aspectRatio: 18 / 9,
                            isLeft: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 8),
                          child: Text(
                            'You',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(1, 1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4, right: 8),
                          child: Text(
                            'Player',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.red),
                          ),
                        ),
                        RotatedBox(
                          quarterTurns: 2,
                          child: SizedBox(
                            width: widget.mediaQuery.size.width > 480 ? 480 * 0.48 : widget.mediaQuery.size.width * 0.48,
                            child: const TrapezoidalWidget(
                              aspectRatio: 18 / 9,
                              isLeft: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Align(
                    alignment: AlignmentDirectional(-0.9, -0.2),
                    child: ScoreWidget(score: 9),
                  ),
                  const Align(
                    alignment: AlignmentDirectional(0.9, 0.4),
                    child: ScoreWidget(score: 6),
                  )
                ],
              ),
            ),
          );
        },
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceBright,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.05),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.25),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(-4, 4),
            ),
            BoxShadow(
              color: Colors.red.withOpacity(0.25),
              blurRadius: 8,
              spreadRadius: 1,
              offset: const Offset(4, -4),
            ),
          ],
        ),
        margin: const EdgeInsets.only(top: 24),
        child: AspectRatio(
          aspectRatio: 18 / 9,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Your last match against Player',
                    style: TextStyle(
                      fontSize: widget.mediaQuery.size.width > 420 ? 16 : 12,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-1, -0.6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: widget.mediaQuery.size.width > 480 ? 480 * 0.48 : widget.mediaQuery.size.width * 0.48,
                      child: const TrapezoidalWidget(
                        aspectRatio: 18 / 9,
                        isLeft: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 8),
                      child: Text(
                        'You',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(1, 1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4, right: 8),
                      child: Text(
                        'Player',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.red),
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 2,
                      child: SizedBox(
                        width: widget.mediaQuery.size.width > 480 ? 480 * 0.48 : widget.mediaQuery.size.width * 0.48,
                        child: const TrapezoidalWidget(
                          aspectRatio: 18 / 9,
                          isLeft: false,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: AlignmentDirectional(-0.9, -0.2),
                child: ScoreWidget(score: 9),
              ),
              const Align(
                alignment: AlignmentDirectional(0.9, 0.4),
                child: ScoreWidget(score: 6),
              )
            ],
          ),
        ),
      );
    }
  }
}
