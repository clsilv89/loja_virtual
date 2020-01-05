import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {
            if (model.isLoading)
              return Center(
                child: CircularProgressIndicator(),
              );
            else
              return Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(hintText: "Nome Completo"),
                      validator: (text) {
                        if (text.isEmpty) return "Nome Inválido";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: "E-mail"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text.isEmpty || !text.contains("@"))
                          return "Email inválido";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(hintText: "Senha"),
                      obscureText: true,
                      validator: (text) {
                        if (text.isEmpty || text.length < 6)
                          return "Senha inválida";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _rePasswordController,
                      decoration: InputDecoration(hintText: "Repetir Senha"),
                      obscureText: true,
                      validator: (text) {
                        if (text.isEmpty || text.length < 6)
                          return "Senha inválida";
                        if (_rePasswordController.text !=
                            _passwordController.text)
                          return "As senhas não conferem";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(hintText: "Endereço"),
                      validator: (text) {
                        if (text.isEmpty) return "Endereço Inválido";
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    SizedBox(
                        height: 44.0,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Map<String, dynamic> userData = {
                                "name": _nameController.text,
                                "email": _emailController.text,
                                "address": _addressController.text
                              };

                              model.signUp(
                                  userData: userData,
                                  pass: _passwordController.text,
                                  onSuccess: _onSuccess,
                                  onFailure: _onFailure);
                            }
                          },
                          child: Text(
                            "Criar Conta",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          textColor: Colors.white,
                          color: Colors.blue,
                        )),
                  ],
                ),
              );
          },
        ));
  }

  void _onSuccess() {
    print("sucesso");
  }

  void _onFailure() {
    print("falhou");
  }
}
