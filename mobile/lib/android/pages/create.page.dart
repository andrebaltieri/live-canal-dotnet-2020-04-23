import 'package:flutter/material.dart';
import 'package:todos/android/pages/home.page.dart';
import 'package:todos/models/todo-item.model.dart';
import 'package:todos/repositories/todo.repository.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  var model = TodoItem();
  final _repository = TodoRepository();
  final _formKey = GlobalKey<FormState>();

  onSubmit() {
    if (!_formKey.currentState.validate()) return;

    model.id = 0;
    model.user = "";
    model.done = false;
    _repository.createTask(model).then((_) {
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

  onError() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova Tarefa"),
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
                    labelText: "Nova Tarefa",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Título inválido';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    model.title = val;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Salvar",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: onSubmit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
