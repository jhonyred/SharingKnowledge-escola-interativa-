import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escola_interativa/app/ad/ad_banner.dart';
import 'package:escola_interativa/app/card/views/widgets/card_widget.dart';
import 'package:flutter/material.dart';

class CardView extends StatefulWidget {
  const CardView({Key? key}) : super(key: key);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference _firestore =
        FirebaseFirestore.instance.collection('publications');

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("ERROR: ${snapshot.error.toString()}"),
          );
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            AdBanner(),
            Expanded(
              child: ListView(
                  children: snapshot.data!.docs.map((publish) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  child: CardWidget(
                    userUID: publish['useruid'],
                    disciplina: publish['disciplina'],
                    semestre: publish['semestre'],
                    instituicao: publish['instituicao'],
                    file: publish['file'],
                  ),
                );
              }).toList()),
            ),
          ],
        );
      },
    );
  }
}
