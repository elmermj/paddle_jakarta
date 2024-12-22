import 'package:flutter/material.dart';

class PromptDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? cancelText;
  final String? confirmText;
  final void Function()? onCancel;
  final void Function()? onConfirm;

  const PromptDialog({
    super.key,
    required this.title,
    required this.message,
    this.cancelText,
    this.confirmText,
    this.onCancel,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actionsPadding: const EdgeInsets.all(4),
      actionsAlignment: MainAxisAlignment.center,
      actionsOverflowButtonSpacing: 16,
      actionsOverflowDirection: VerticalDirection.down,
      actions: [
        if (cancelText != null)
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 4),
              ),
              onPressed: onCancel,
              child: Text(cancelText!),
            ),
          ),
        if (confirmText != null)
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 4),
              ),
              onPressed: onConfirm,
              child: Text(confirmText!),
            ),
          ),
      ],
    );
  }
}