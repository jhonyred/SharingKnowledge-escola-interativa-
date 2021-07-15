import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escola_interativa/app/core/core.dart';
import 'package:escola_interativa/app/share/api/firebase_api.dart';
import 'package:escola_interativa/app/share/views/widgets/selected_image_widget.dart';
import 'package:escola_interativa/app/share/views/widgets/share_button_widget.dart';
import 'package:escola_interativa/app/share/views/widgets/share_text_form_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ShareView extends StatefulWidget {
  ShareView({
    required this.userUID,
  });

  final String userUID;

  @override
  _ShareViewState createState() => _ShareViewState();
}

class _ShareViewState extends State<ShareView> {
  final _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final _disciplina = TextEditingController();
  final _semestre = TextEditingController();
  final _instituicao = TextEditingController();

  File? file;
  UploadTask? task;
  Widget? contador;
  bool clickFile = false;
  bool _progress = false;

  @override
  Widget build(BuildContext context) {
    final fileName =
        file != null ? basename(file!.path) : 'Nenhum Arquivo Selecionado';
    return Scaffold(
      appBar: AppBar(
        title: Text("Compartilhar"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(22.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 120.0,
                  width: 150.0,
                  // color: AppColors.white,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: AppColors.darkRed,
                      )),
                  child: Image.asset(
                    AppImages.imgShare,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 8.0),
                SelectedImageWidget(
                  icon: Icons.attach_file,
                  text: "Selecionar Arquivo",
                  onClicked: _selectFile,
                ),
                SizedBox(height: 8.0),
                Center(
                  child: Text(
                    clickFile == true ? fileName : 'Nenhum Arquivo Selecionado',
                  ),
                ),
                SizedBox(height: 8.0),
                ShareTextFormWidget(
                  hint: 'Disciplina',
                  keyboardType: TextInputType.name,
                  controller: _disciplina,
                  validator: (String? text) {
                    if (text!.isEmpty) {
                      return "Campo obrigatório";
                    }
                  },
                ),
                ShareTextFormWidget(
                  hint: 'Número do semestre',
                  keyboardType: TextInputType.number,
                  controller: _semestre,
                  validator: (String? text) {
                    if (text!.isEmpty) {
                      return "Campo obrigatório";
                    }
                  },
                ),
                ShareTextFormWidget(
                  hint: 'Instituição de ensino',
                  keyboardType: TextInputType.name,
                  controller: _instituicao,
                  validator: (String? text) {
                    if (text!.isEmpty) {
                      return "Campo obrigatório";
                    }
                  },
                ),
                SizedBox(height: 32.0),
                ShareButtonWidget(
                  progress: _progress,
                  color: AppColors.red,
                  title: "Compartilhar",
                  onPressed: _uploadFile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ["pdf"],
    );

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
      task = null;
      clickFile = true;
    });
  }

  Future _uploadFile() async {
    // Validando Arquivo selecionado
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'files/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);

    // Validando campos preenchidos
    bool formValidator = _formKey.currentState!.validate();
    if (!formValidator) {
      return;
    }

    setState(() {
      _progress = true;
    });

    // Adicionando Arquivo ao DataBase
    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    // Adicinado dados ao DataBase
    _firestore.collection('publications').add({
      'useruid': widget.userUID,
      'disciplina': _disciplina.text.toUpperCase(),
      'semestre': _semestre.text,
      'instituicao': _instituicao.text,
      'file': urlDownload,
    });

    setState(() {
      _progress = false;
      clickFile = false;
    });

    _disciplina.clear();
    _semestre.clear();
    _instituicao.clear();
  }
}
