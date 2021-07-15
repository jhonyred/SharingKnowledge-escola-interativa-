import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escola_interativa/app/core/core.dart';
import 'package:escola_interativa/app/perfil/views/widgets/perfil_description_widget.dart';
import 'package:escola_interativa/app/perfil/views/widgets/perfil_listtile_widget.dart';
import 'package:escola_interativa/app/perfil/views/widgets/perfil_text_form_widget.dart';
import 'package:escola_interativa/app/perfil/views/widgets/update_button_widget.dart';
import 'package:escola_interativa/app/share/api/firebase_api.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class PerfilView extends StatefulWidget {
  final Function() onPressed;
  final String userUID;

  PerfilView({
    required this.onPressed,
    required this.userUID,
  });

  @override
  State<PerfilView> createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  final _firestore = FirebaseFirestore.instance.collection('users');

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _curso = TextEditingController();

  bool clickPhoto = false;
  bool clickName = false;
  bool clickCurso = false;
  bool _progress = false;

  File? file;
  UploadTask? task;

  @override
  Widget build(BuildContext context) {
    final fileName =
        file != null ? basename(file!.path) : "Adicionar nova foto";
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: widget.onPressed,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: FutureBuilder(
          future: _firestore.doc(widget.userUID).get(),
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
              return ListView(
                children: [
                  // Descrição do Perfil Usuário
                  PerfilDescription(
                    photo: dataUser['photo'],
                    name: dataUser['name'],
                    email: dataUser['email'],
                    curso: dataUser['curso'],
                  ),

                  // UpDate Photo Perfil Usuário
                  PerfilListTile(
                    icon: Icon(Icons.camera_alt),
                    title: "Editar foto",
                    subtitle:
                        clickPhoto == true ? fileName : "Adicionar nova foto",
                    onTap: _selectFile,
                  ),

                  // Update Nome Perfil Usuário
                  clickName == true
                      ? PerfilTextForm(
                          controller: _name,
                          hintText: "Nome",
                          validator: (String? text) {
                            if (text!.isEmpty) {
                              return "Campo obrigatório";
                            }
                          })
                      : PerfilListTile(
                          icon: Icon(Icons.person),
                          title: "Editar nome",
                          subtitle: dataUser['name'],
                          onTap: () {
                            setState(() {
                              clickName = true;
                            });
                          },
                        ),

                  // Update Curso Perfil Usuário
                  clickCurso == true
                      ? PerfilTextForm(
                          controller: _curso,
                          hintText: "Curso",
                          validator: (String? text) {
                            if (text!.isEmpty) {
                              return "Campo obrigatório";
                            }
                          })
                      : PerfilListTile(
                          icon: Icon(Icons.school),
                          title: "Editar curso",
                          subtitle: dataUser['curso'],
                          onTap: () {
                            setState(() {
                              clickCurso = true;
                            });
                          },
                        ),
                  SizedBox(
                    height: 20.0,
                  ),

                  // Botão Cancelar
                  clickPhoto || clickName || clickCurso == true
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 80.0),
                          child: UpdateButton(
                              color: AppColors.red,
                              title: "Cancelar",
                              onPressed: () {
                                setState(() {
                                  clickName = false;
                                  clickCurso = false;
                                  clickPhoto = false;
                                });
                              }),
                        )
                      : Container(),

                  SizedBox(
                    height: 10.0,
                  ),
                  // Botão Salvar
                  clickPhoto || clickName || clickCurso == true
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 80.0),
                          child: UpdateButton(
                              progress: _progress,
                              color: AppColors.red,
                              title: "Salvar",
                              onPressed: () {
                                // await _updateUser();
                                if (clickPhoto == true) {
                                  _updatePhoto();
                                }
                                if (clickName || clickCurso == true) {
                                  _updateUser();
                                }
                              }),
                        )
                      : Container(),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
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
      clickPhoto = true;
    });
  }

  Future _updatePhoto() async {
    //Validando Arquivo selecionado
    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = 'photos/$fileName';

    task = FirebaseApi.uploadFile(destination, file!);
    setState(() {
      _progress = true;
    });

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlPhoto = await snapshot.ref.getDownloadURL();

    // Update User
    try {
      _firestore
          .doc(widget.userUID)
          .update({'photo': urlPhoto})
          .then((value) => print("Usuário Atualizado"))
          .catchError((error) => print("Erro ao Atualizar Usuário: $error"));
    } catch (e) {
      print("Falha ao Atualizar perfil do usuário: $e");
    }

    setState(() {
      _progress = false;

      clickPhoto = false;
    });
  }

  Future _updateUser() async {
    // Validando campos preenchidos
    bool formValidator = _formKey.currentState!.validate();
    if (!formValidator) {
      return;
    }

    setState(() {
      _progress = true;
    });

    String name = _name.text;
    String curso = _curso.text;

    // Update User
    try {
      if (name != "") {
        _firestore
            .doc(widget.userUID)
            .update({'name': name})
            .then((value) => print("Usuário Atualizado"))
            .catchError((error) => print("Erro ao Atualizar Usuário: $error"));
      }
      if (curso != "") {
        _firestore
            .doc(widget.userUID)
            .update({'curso': curso})
            .then((value) => print("Usuário Atualizado"))
            .catchError((error) => print("Erro ao Atualizar Usuário: $error"));
      }
    } catch (e) {
      print("Falha ao Atualizar perfil do usuário: $e");
    }

    setState(() {
      _progress = false;
      clickName = false;
      clickCurso = false;
    });
  }

  // Future _updateUser() async {
  //   //Validando Arquivo selecionado
  //   if (file == null) return;

  //   final fileName = basename(file!.path);
  //   final destination = 'photos/$fileName';

  //   task = FirebaseApi.uploadFile(destination, file!);

  //   // Validando campos preenchidos
  //   bool formValidator = _formKey.currentState!.validate();
  //   if (!formValidator) {
  //     return;
  //   }

  //   setState(() {
  //     _progress = true;
  //   });

  //   if (task == null) return;

  //   final snapshot = await task!.whenComplete(() {});
  //   final urlPhoto = await snapshot.ref.getDownloadURL();

  //   String name = _name.text;
  //   String curso = _curso.text;

  //   // Update User
  //   try {
  //     if (urlPhoto != "") {
  //       _firestore
  //           .doc(widget.userUID)
  //           .update({'photo': urlPhoto})
  //           .then((value) => print("Usuário Atualizado"))
  //           .catchError((error) => print("Erro ao Atualizar Usuário: $error"));
  //     }

  //     if (name != "") {
  //       _firestore
  //           .doc(widget.userUID)
  //           .update({'name': name})
  //           .then((value) => print("Usuário Atualizado"))
  //           .catchError((error) => print("Erro ao Atualizar Usuário: $error"));
  //     }
  //     if (curso != "") {
  //       _firestore
  //           .doc(widget.userUID)
  //           .update({'curso': curso})
  //           .then((value) => print("Usuário Atualizado"))
  //           .catchError((error) => print("Erro ao Atualizar Usuário: $error"));
  //     }
  //   } catch (e) {
  //     print("Falha ao Atualizar perfil do usuário: $e");
  //   }

  //   setState(() {
  //     _progress = false;
  //   });
  // }
}
