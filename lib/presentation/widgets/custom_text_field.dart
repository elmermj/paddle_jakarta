import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final String labelText;
  final IconButton? suffixIcon;
  final ValueListenable<String?>? valueListenable;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    required this.labelText,
    this.valueListenable,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    if(valueListenable == null) {
      return TextField(
        keyboardType: keyboardType,
        onChanged: validator,
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          label: Text(labelText),
          suffixIcon: suffixIcon,
        ),
      );
    }
    else{
      return ValueListenableBuilder<String?>(
        valueListenable: valueListenable!,
        builder: (context, error, state) {
          return TextField(
            keyboardType: keyboardType,
            onChanged: validator,
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              label: Text(labelText),
              suffixIcon: suffixIcon,
              errorText: error
            ),
          );
        },
      );
    }
  }
}
