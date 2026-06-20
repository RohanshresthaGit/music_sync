import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.hintText,
    this.isReadOnly = false,
    this.isObsecure = false,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.maxLines,
    required this.controller,
  });
  final int? maxLines;
  final String? hintText;
  final bool isReadOnly, isObsecure;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      controller: controller,
      validator: validator,
      readOnly: isReadOnly,
      obscureText: isObsecure,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: !isReadOnly && suffixIcon != null ? suffixIcon : null,
      ),
    );
  }
}
