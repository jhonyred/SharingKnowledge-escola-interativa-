import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escola_interativa/app/core/core.dart';
import 'package:escola_interativa/app/login/views/widgets/login_button_widget.dart';
import 'package:escola_interativa/app/login/views/widgets/text_form_widget.dart';
import 'package:escola_interativa/app/share/api/firebase_api.dart';
import 'package:escola_interativa/app/share/views/widgets/selected_image_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class PerfilRegisterView extends StatefulWidget {
  const PerfilRegisterView({Key? key}) : super(key: key);

  @override
  _PerfilRegisterViewState createState() => _PerfilRegisterViewState();
}

class _PerfilRegisterViewState extends State<PerfilRegisterView> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  User? loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _curso = TextEditingController();
  bool _progress = false;

  File? file;
  UploadTask? task;
  Widget? contador;

  @override
  Widget build(BuildContext context) {
    final fileName =
        file != null ? basename(file!.path) : 'Nenhum Arquivo Selecionado';
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(22.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40.0,
                ),
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
                  icon: Icons.camera_alt,
                  text: "Adicionar Foto",
                  onClicked: _selectFile,
                ),
                SizedBox(height: 8.0),
                Center(
                  child: Text(
                    fileName,
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormWidget(
                  label: "Nome",
                  hint: "Digite seu nome",
                  obscure: false,
                  controller: _name,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (String? text) {
                    if (text!.isEmpty) {
                      return "Insira seu nome";
                    }
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormWidget(
                  label: "Curso",
                  hint: "Digite seu curso",
                  obscure: false,
                  controller: _curso,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (String? text) {
                    if (text!.isEmpty) {
                      return "Insira seu curso";
                    }
                  },
                ),
                SizedBox(height: 32.0),
                LoginButton(
                    progress: _progress,
                    color: AppColors.red,
                    title: 'Cadastrar',
                    onPressed: () {
                      _registerUser(context);
                    }),
                SizedBox(
                  height: 24.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print("UID do Usuário: ${loggedInUser!.uid}");
      }
    } catch (e) {
      print("Error: $e não foi possível obter UID do Usuário");
    }
  }

  Future _selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
      task = null;
    });
  }

  Future _registerUser(BuildContext context) async {
    // Validando Arquivo selecionado
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'photos/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);

    // Validando campos preenchidos
    bool formValidator = _formKey.currentState!.validate();
    if (!formValidator) {
      return;
    }

    setState(() {
      _progress = true;
    });

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlPhoto = await snapshot.ref.getDownloadURL();

    // print("Download-Link: $urlPhoto");
    // print("UID do Usuário: ${loggedInUser.uid}");

    try {
      _firestore
          .collection('users')
          .doc(loggedInUser!.uid)
          .set({
            'name': _name.text,
            'curso': _curso.text,
            'photo': urlPhoto,
            'email': loggedInUser!.email
          })
          .then((value) => print("Usuário Adicionado!!!"))
          .catchError((error) => print("Falha ao adicionar usuário: $error"));
      Navigator.of(context).pushReplacementNamed('/home');
    } catch (e) {
      print("Falha ao adicionar usuário: $e");
    }

    setState(() {
      _progress = false;
    });
  }
}
