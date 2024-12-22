import 'package:flutter/material.dart';
import 'package:paddle_jakarta/presentation/views/home/viewmodels/home_viewmodel.dart';

class NavBarItemWidget extends StatelessWidget {
  const NavBarItemWidget({
    super.key,
    required this.index,
    required this.icon,
    required this.viewModel,
    required this.width
  });

  final double width;
  final int index;
  final IconData icon;
  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) =>
  SizedBox(
    width: width,
    child: Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IconButton(
          onPressed: () => viewModel.switchHomeState(index: index),
          style: TextButton.styleFrom(
            backgroundColor: index == viewModel.indexState
          ? Theme.of(context).colorScheme.surface.withOpacity(0.75)
          : Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            )
          ),
          icon: Icon(
            icon,
            color: index == viewModel.indexState
          ? Theme.of(context).colorScheme.primary
          : Colors.white,
          )
        ),
      ),
    ),
  );
}