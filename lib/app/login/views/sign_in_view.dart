import 'package:escola_interativa/app/core/core.dart';
import 'package:escola_interativa/app/login/views/widgets/login_button_widget.dart';
import 'package:escola_interativa/app/login/views/widgets/text_form_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
                label: "Usuário",
                hint: "Digite seu e-mail",
                obscure: false,
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (String? text) {
                  if (text!.isEmpty) {
                    return "Digite o Usuário Novamente!";
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
                    return "Digite a Senha Novamente!";
                  } else if (text.length < 8) {
                    return "Senha menor de 8 digitos";
                  }
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              LoginButton(
                progress: _progress,
                color: AppColors.red,
                title: 'Entrar',
                onPressed: _loginIn,
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

  Future _loginIn() async {
    bool formValidator = _formKey.currentState!.validate();
    if (!formValidator) {
      return;
    }
    String email = _email.text;
    String password = _password.text;

    setState(() {
      _progress = true;
    });

    try {
      final UserCredential? user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        Navigator.of(context).pushReplacementNamed('/home');
        // Navigator.pushNamed(context, '/home');
      }
    } catch (e) {
      print("Erro Usuário não Cadastrado: $e");
    }

    setState(() {
      _progress = false;
    });
  }
}
