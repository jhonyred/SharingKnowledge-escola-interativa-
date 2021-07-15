import 'package:escola_interativa/app/core/core.dart';
import 'package:escola_interativa/app/login/views/widgets/login_button_widget.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 350.0,
                width: 350.0,
                child: Image.asset(AppImages.imgLogin1),
              ),
              SizedBox(height: 10.0),
              LoginButton(
                color: AppColors.red,
                title: 'Entrar',
                onPressed: () {
                  // Navigator.pushNamed(context, '/signin');
                  Navigator.of(context).pushReplacementNamed('/signin');
                },
              ),
              LoginButton(
                color: AppColors.red,
                title: 'Cadastre-se',
                onPressed: () {
                  // Navigator.pushNamed(context, '/register');
                  Navigator.of(context).pushReplacementNamed('/register');
                },
              ),
              SizedBox(height: 10.0),
              Container(
                height: 70.0,
                width: 125.0,
                child: Image.asset(AppImages.imgLogin2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
