import 'package:flutter/material.dart';

class ShareTextFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String hint;
  final FormFieldValidator<String>? validator;

  ShareTextFormWidget({
    required this.controller,
    required this.keyboardType,
    required this.hint,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(hintText: hint),
      validator: validator,
    );
  }
}
