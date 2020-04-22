import 'package:flutter/material.dart';
import 'package:todos/android/pages/home.page.dart';
import 'package:todos/android/pages/join.page.dart';
import 'package:todos/models/user.model.dart';
import 'package:todos/repositories/todo.repository.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var model = UserModel();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _repository = TodoRepository();
  final _formKey = GlobalKey<FormState>();

  onSubmit() {
    if (!_formKey.currentState.validate()) return;

    _repository.login(model).then((_) {
      onSuccess();
    }).catchError((_) {
      onError();
    });
  }

  onSuccess() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  onError() {
    final snackBar = SnackBar(
      content: Text('Usuário ou senha inválidos'),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Minhas Tarefas"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Username",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Usuário inválido';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    model.username = val;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Senha inválida';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    model.password = val;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Entrar",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: onSubmit,
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  child: Text("Cadastrar"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JoinPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
