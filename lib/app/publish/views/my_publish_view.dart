import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escola_interativa/app/ad/ad_banner.dart';
import 'package:escola_interativa/app/card/views/widgets/card_widget.dart';
import 'package:flutter/material.dart';

class MyPublishView extends StatefulWidget {
  final String userUID;

  MyPublishView({
    required this.userUID,
  });

  @override
  State<MyPublishView> createState() => _MyPublishViewState();
}

class _MyPublishViewState extends State<MyPublishView> {
  QuerySnapshot? snapshotData;
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    _queryData(widget.userUID).then((value) {
      snapshotData = value;
      print("Error minhas publicações: ${widget.userUID}");
      setState(() {
        isloading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas publicações"),
        centerTitle: true,
      ),
      body: isloading
          ? _myPublishData()
          : Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  Future _queryData(String uid) async {
    return FirebaseFirestore.instance
        .collection('publications')
        .where('useruid', isEqualTo: uid)
        .get();
  }

  Widget _myPublishData() {
    return Column(
      children: [
        AdBanner(),
        Expanded(
          child: ListView.builder(
              itemCount: snapshotData!.docs.length,
              itemBuilder: (BuildContext context, index) {
                return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    child: CardWidget(
                      userUID: snapshotData!.docs[index]['useruid'],
                      disciplina: snapshotData!.docs[index]['disciplina'],
                      semestre: snapshotData!.docs[index]['semestre'],
                      instituicao: snapshotData!.docs[index]['instituicao'],
                      file: snapshotData!.docs[index]['file'],
                      progress: true,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Confimar"),
                            content: Text(
                                "Clique em OK deletar a publicação: ${snapshotData!.docs[index]['disciplina']}"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancelar'),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  snapshotData!.docs[index].reference.delete();

                                  Navigator.pop(context, 'OK');
                                  Navigator.of(context)
                                      .pushReplacementNamed('/home');

                                  print("Publicação excluiada com sucesso!!!");
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                    ));
              }),
        ),
      ],
    );
  }
}
