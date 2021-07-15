// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escola_interativa/app/card/views/card_view.dart';
// import 'package:escola_interativa/app/home/views/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text("Sharing Knowledge"),
        centerTitle: true,
      ),
      body: CardView(),
    );
  }
}
