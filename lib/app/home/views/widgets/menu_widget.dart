import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:escola_interativa/app/core/core.dart';
import 'package:escola_interativa/app/home/views/home_view.dart';
import 'package:escola_interativa/app/perfil/views/perfil_view.dart';
import 'package:escola_interativa/app/publish/views/my_publish_view.dart';
import 'package:escola_interativa/app/search/views/search_view.dart';
import 'package:escola_interativa/app/share/views/share_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print("UID do Usuário: ${loggedInUser.uid}");
      }
    } catch (e) {
      print("Erro ao verificar o Usuário: $e");
    }
  }

  int selectedView = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> views = [
      HomeView(),
      SearchView(),
      ShareView(
        userUID: loggedInUser.uid,
      ),
      // FavoriteView(),
      MyPublishView(
        userUID: loggedInUser.uid,
      ),
      PerfilView(
        userUID: loggedInUser.uid,
        onPressed: () {
          _auth.signOut();
          // Navigator.pop(context);
          Navigator.of(context).pushReplacementNamed('/login');
        },
      ),
    ];

    return Scaffold(
      body: views[selectedView],
      bottomNavigationBar: CurvedNavigationBar(
        index: selectedView,
        backgroundColor: AppColors.lightRed,
        // color: AppColors.darkRed,
        // buttonBackgroundColor: AppColors.white,
        items: [
          Icon(
            Icons.home,
            size: 30.0,
          ),
          Icon(
            Icons.search,
            size: 30.0,
          ),
          Icon(
            Icons.add_box_outlined,
            size: 30.0,
          ),
          Icon(
            Icons.file_upload_outlined,
            size: 30.0,
          ),
          Icon(
            Icons.person,
            size: 30.0,
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedView = index;
          });
        },
      ),
    );
  }
}
