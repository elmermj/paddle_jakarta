import 'package:flutter/material.dart';

class TimelineCategoryItemWidget extends StatelessWidget {
  const TimelineCategoryItemWidget({
    super.key,
    required this.onTap, required this.title,
  });

  final void Function()? onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      splashColor: Theme.of(context).colorScheme.primary.withOpacity(1),
      highlightColor: Theme.of(context).colorScheme.primary.withOpacity(1),
      hoverColor: Theme.of(context).colorScheme.primary.withOpacity(1),
      hoverDuration: Durations.short3,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceBright,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.05),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}