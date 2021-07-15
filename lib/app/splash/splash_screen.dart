import 'dart:async';

import 'package:escola_interativa/app/core/app_images.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //Ir para tela de Login
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              //Imagem de Fundo
              AppImages.logoBackground,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          // Imagem Logo
          child: Image.asset(AppImages.logoSplash),
        ),
      ),
    );
  }
}
