import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escola_interativa/app/card/views/widgets/card_widget.dart';
import 'package:escola_interativa/app/core/core.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _formKey = GlobalKey<FormState>();
  final _search = TextEditingController();
  QuerySnapshot? snapshotData;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Form(
          key: _formKey,
          child: TextFormField(
            style: AppTextStyles.textSearch,
            decoration: InputDecoration(
              hintText: "Pesquisar",
              hintStyle: AppTextStyles.textSearch,
            ),
            cursorColor: AppColors.white,
            controller: _search,
            validator: (String? text) {
              if (text!.isEmpty) {
                return "Campo obrigatório";
              }
            },
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              bool formValidator = _formKey.currentState!.validate();
              if (!formValidator) {
                return;
              }
              _queryData(_search.text.toUpperCase()).then((value) {
                snapshotData = value;
                setState(() {
                  isloading = true;
                });
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _queryData(_search.text).then((value) {
                snapshotData = value;
                setState(() {
                  isloading = false;
                  _search.clear();
                });
              });
            },
          )
        ],
      ),
      body: isloading
          ? _searchData()
          : Container(
              child: Center(
                child: Text("Nenhum arquivo encontrado"),
              ),
            ),
    );
  }

  Future _queryData(String querySearch) async {
    return FirebaseFirestore.instance
        .collection('publications')
        .where('disciplina', isGreaterThanOrEqualTo: querySearch)
        .get();
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
              ));
        });
  }
}
