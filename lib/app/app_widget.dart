import 'package:escola_interativa/app/core/app_colors.dart';
import 'package:escola_interativa/app/favorite/views/favorite_view.dart';

import 'package:escola_interativa/app/home/views/widgets/menu_widget.dart';
import 'package:escola_interativa/app/login/views/perfil_register_view.dart';
import 'package:escola_interativa/app/login/views/register_view.dart';
import 'package:escola_interativa/app/login/views/sign_in_view.dart';
import 'package:escola_interativa/app/login/views/login_view.dart';
import 'package:escola_interativa/app/publish/views/downloaded_view.dart';
import 'package:escola_interativa/app/settings/views/settings_view.dart';
import 'package:escola_interativa/app/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sharing Knowledge',
      theme: ThemeData(
        //Configuração de cores
        primaryColor: AppColors.red,
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: AppColors.lightRed,
        backgroundColor: AppColors.lightRed,
      ),
      //Rota Principal de Tela
      initialRoute: '/',
      //Configuração de Rotas
      routes: {
        '/': (context) => SplashScreen(), //Tela de Exibição
        '/login': (context) => LoginView(), //Tela de Login
        '/register': (context) => RegisterView(), //Tela de Cadastro
        '/signin': (context) => SignInView(), //Tela de entrar com E-mail
        '/home': (context) => MenuWidget(), //Menu
        '/favorite': (context) => FavoriteView(), //Tela de Favoritos
        '/downloaded': (context) => DownloadedPublishView(), //Tela de Baixados
        '/settings': (context) => SettingsView(), //Tela de Configurações
        '/perfilregister': (context) => PerfilRegisterView(),
      },
    );
  }
}
