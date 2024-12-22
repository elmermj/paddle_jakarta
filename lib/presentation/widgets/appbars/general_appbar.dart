import 'package:flutter/material.dart';

class GeneralAppBar extends StatelessWidget {
  final String title;
  const GeneralAppBar({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width, 
      height: kToolbarHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            )
          ),
        ],
      ),
    );
  }
}
