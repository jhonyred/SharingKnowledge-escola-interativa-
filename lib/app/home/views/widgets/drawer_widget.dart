import 'package:escola_interativa/app/core/app_colors.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: AppColors.lightRed,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://pbs.twimg.com/profile_images/1238216763118059520/z7Fi--3w_400x400.jpg'),
                ),
                accountName: Text("User teste"),
                accountEmail: Text("user@email.com"),
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text("Favoritos"),
                subtitle: Text("Mais informações..."),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  print("Favorito");
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/favorite');
                },
              ),
              ListTile(
                leading: Icon(Icons.upload),
                title: Text("Minhas publicações"),
                subtitle: Text("Mais informações..."),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  print("Minhas publicações");
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/mypublish');
                },
              ),
              ListTile(
                leading: Icon(Icons.download),
                title: Text("Publicações baixadas"),
                subtitle: Text("Mais informações..."),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  print("Publicações baixadas");
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/downloaded');
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Configurações"),
                subtitle: Text("Mais informações..."),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  print("Configurações");
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  print("Logout");
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
