import 'package:escola_interativa/app/core/core.dart';
import 'package:escola_interativa/app/login/views/widgets/login_button_widget.dart';
import 'package:escola_interativa/app/login/views/widgets/text_form_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _progress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              Flexible(
                child: Container(
                  height: 250.0,
                  width: 250.0,
                  child: Image.asset(AppImages.imgLogin1),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormWidget(
                label: "E-mail",
                hint: "Digite seu e-mail",
                obscure: false,
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (String? text) {
                  if (text!.isEmpty) {
                    return "Insira seu e-mail";
                  }
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormWidget(
                label: "Senha",
                hint: "Digite sua senha",
                obscure: true,
                controller: _password,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                validator: (String? text) {
                  if (text!.isEmpty) {
                    return "Insira uma senha";
                  } else if (text.length < 8) {
                    return "A senha não pode ser menor que 8 digitos";
                  }
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              LoginButton(
                progress: _progress,
                color: AppColors.red,
                title: 'Próximo',
                onPressed: _register,
              ),
              SizedBox(
                height: 24.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _register() async {
    bool formValidator = _formKey.currentState!.validate();
    if (!formValidator) {
      return;
    }
    String email = _email.text;
    String password = _password.text;
    // print("E-mail: $email");
    // print("Senha: $password");

    setState(() {
      _progress = true;
    });

    try {
      final UserCredential? registerNewUser =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (registerNewUser != null) {
        Navigator.of(context).pushReplacementNamed('/perfilregister');
        // print("Resultando $registerNewUser");
      }
    } catch (e) {
      print("Erro ao Cadastrar Usuário: $e");
    }

    setState(() {
      _progress = false;
    });
  }
}
