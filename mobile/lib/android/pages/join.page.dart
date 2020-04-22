import 'package:flutter/material.dart';
import 'package:todos/android/pages/login.page.dart';
import 'package:todos/models/user.model.dart';
import 'package:todos/repositories/todo.repository.dart';

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  var model = UserModel();
  final _repository = TodoRepository();
  final _formKey = GlobalKey<FormState>();

  onSubmit() {
    if (!_formKey.currentState.validate()) return;

    _repository.create(model).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }).catchError((_) {
      print(_);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Cadastrar",
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
                  child: Text("Cancelar"),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
