import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:paddle_jakarta/data/models/timeline_item_model.dart';
import 'package:paddle_jakarta/data/models/user_model.dart';

class TimelineItemWidget extends StatelessWidget {
  final TimelineItemModel timelineItem;
  final bool isLast;
  final bool isFirst;
  TimelineItemWidget({
    super.key,
    required this.timelineItem,
    required this.isLast,
    required this.isFirst,
  });

  final Box<UserModel> userDataBox = Hive.box<UserModel>('userDataBox');

  @override
  Widget build(BuildContext context) {
    // Format timestamp to HH:MM, DD MMM YYYY
    final date = DateTime.fromMillisecondsSinceEpoch(timelineItem.timestamp!.seconds * 1000);
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final formattedDate = '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}, ${date.day.toString().padLeft(2, '0')} ${months[date.month - 1]} ${date.year}';
    
    final title = typeBuilder(timelineItem.type!, timelineItem.title!);

    return Row(
      children: [
        Expanded(
          child: Stack(
            children: _buildTimelineIndicators(context),
          ),
        ),
        Expanded(
          flex: 9,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.surface.withOpacity(0.25),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  formattedDate,
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.75),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildTimelineIndicators(BuildContext context) {
    final indicators = <Widget>[];

    if (!isFirst) {
      indicators.add(
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 50,
            width: 1,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
            ),
          ),
        ),
      );
    }

    if (!isLast) {
      indicators.add(
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 50,
            width: 1,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
            ),
          ),
        ),
      );
    }

    indicators.add(
      Align(
        alignment: Alignment.center,
        child: Container(
          height: 4,
          width: 4,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.onPrimary,
                blurRadius: 4,
                spreadRadius: 0,
                offset: Offset(0, isFirst ? 4 : isLast ? -4 : 0),
              ),
            ],
          ),
        ),
      ),
    );

    return indicators;
  }

  String typeBuilder(String type, String title) {
    switch (type) {
      case "event":
        return "${userDataBox.get("userData")!.displayName} $title";
      case "task":
        return "Task";
      case "reminder":
        return "Reminder";
      case "note":
        return "Note";
      case "todo":
        return "To-Do";
      case "birthday":
        return "Birthday";
      case "anniversary":
        return "Anniversary";
      case "other":
      default:
        return "Other";
    }
  }
}
