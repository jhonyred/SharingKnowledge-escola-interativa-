import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escola_interativa/app/card/views/widgets/card_publish_widget.dart';
import 'package:escola_interativa/app/card/views/widgets/user_description_widget.dart';
import 'package:escola_interativa/app/core/core.dart';
import 'package:escola_interativa/app/pdf/views/pdf_viewer.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String userUID;
  final String disciplina;
  final String semestre;
  final String instituicao;
  final String file;
  final bool progress;
  final Function()? onPressed;

  CardWidget({
    required this.userUID,
    required this.disciplina,
    required this.semestre,
    required this.instituicao,
    required this.file,
    this.progress = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance.collection('users');
    return FutureBuilder(
      future: _firestore.doc(userUID).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("ERROR: ${snapshot.error.toString()}"),
          );
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Dados do Usuário não Encontrado");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> dataUser =
              snapshot.data!.data() as Map<String, dynamic>;
          return Card(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserDescription(
                    photo: dataUser['photo'],
                    name: dataUser['name'],
                    curso: dataUser['curso'],
                  ),
                  Container(
                    height: 1.0,
                    width: 100.0 * 10,
                    color: AppColors.light,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  GestureDetector(
                    child: CardPublishWidget(
                      disciplina: disciplina,
                      semestre: semestre,
                      instituicao: instituicao,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PdfViewer(
                                  disciplina: disciplina,
                                  file: file,
                                )),
                      );
                    },
                  ),
                  progress == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            const SizedBox(width: 8),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: AppColors.red,
                              ),
                              onPressed: onPressed,
                            ),
                            const SizedBox(width: 8),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
