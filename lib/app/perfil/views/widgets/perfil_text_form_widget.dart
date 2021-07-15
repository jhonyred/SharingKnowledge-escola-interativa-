import 'package:escola_interativa/app/core/core.dart';
import 'package:flutter/material.dart';

class PerfilTextForm extends StatelessWidget {
  PerfilTextForm({
    required this.controller,
    required this.hintText,
    required this.validator,
  });

  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
        ),
        cursorColor: AppColors.red,
        controller: controller,
        validator: validator,
      ),
    );
  }
}
