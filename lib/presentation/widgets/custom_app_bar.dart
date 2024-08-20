import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final String bottomText;
  final void Function()? onBackFunction;

  const CustomAppBar({
    super.key,
    this.title = 'Paddle Jakarta', this.bottomText = '', this.onBackFunction,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: Navigator.canPop(context)
    ? IconButton(
        onPressed: () {
          onBackFunction;
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded),
      )
    : null,
      bottom: bottomText.isNotEmpty
    ? PreferredSize(
        preferredSize: preferredSize*20, 
        child: Row(
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
              flex: 4,
              child: Text(
                bottomText,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        )
      )
    : null,
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}