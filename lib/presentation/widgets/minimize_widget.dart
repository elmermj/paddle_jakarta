import 'package:flutter/material.dart';

class MinimizeWidget extends StatefulWidget {
  final Widget child;
  final Widget minimizedChild;
  final bool isMinimize;
  final void Function()? onTap;

  const MinimizeWidget({
    required this.child,
    Key? key,
    required this.isMinimize,
    this.onTap, required this.minimizedChild,
  }) : super(key: key);

  @override
  MinimizeWidgetState createState() => MinimizeWidgetState();
}

class MinimizeWidgetState extends State<MinimizeWidget> {

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Durations.medium2,
      reverseDuration: Durations.medium2,
      transitionBuilder: (Widget child, Animation<double> animation) => ScaleTransition(scale: animation, child: child),
      child: InkWell(
        onTap: widget.onTap,
        child: widget.isMinimize? widget.minimizedChild: widget.child,
      ),
    );
  }
}
