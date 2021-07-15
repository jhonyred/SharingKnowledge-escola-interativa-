import 'package:escola_interativa/app/core/core.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Color color;
  final String title;
  final Function()? onPressed;
  final bool progress;

  LoginButton({
    required this.color,
    required this.title,
    required this.onPressed,
    this.progress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(30.0),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 200.0,
        height: 52.0,
        child: progress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                title,
                style: AppTextStyles.textLoginButton2,
              ),
      ),
    );
  }
}
