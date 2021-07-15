import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escola_interativa/app/card/views/widgets/card_widget.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  QuerySnapshot? snapshotData;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
      ),
      body: isloading
          ? _searchData()
          : Container(
              child: Center(
                child: Text("Favoritos"),
              ),
            ),
    );
  }

  Widget _searchData() {
    return ListView.builder(
        itemCount: snapshotData!.docs.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: CardWidget(
              userUID: snapshotData!.docs[index]['useruid'],
              disciplina: snapshotData!.docs[index]['disciplina'],
              semestre: snapshotData!.docs[index]['semestre'],
              instituicao: snapshotData!.docs[index]['instituicao'],
              file: snapshotData!.docs[index]['file'],
            ),
          );
        });
  }
}
