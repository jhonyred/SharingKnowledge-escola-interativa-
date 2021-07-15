import 'package:escola_interativa/app/core/app_colors.dart';
import 'package:escola_interativa/app/core/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormWidget extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscure;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;

  TextFormWidget({
    required this.label,
    required this.hint,
    required this.obscure,
    required this.controller,
    required this.keyboardType,
    required this.textInputAction,
    required this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      style: AppTextStyles.textForm,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        labelText: label,
        labelStyle: TextStyle(color: AppColors.grey),
        hintText: hint,
      ),
    );
  }
}
