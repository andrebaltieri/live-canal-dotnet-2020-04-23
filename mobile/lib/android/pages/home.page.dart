import 'package:flutter/material.dart';
import 'package:todos/android/pages/create.page.dart';
import 'package:todos/repositories/todo.repository.dart';
import 'package:todos/settings.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _repository = TodoRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Tarefas"),
        centerTitle: true,
        leading: Container(),
      ),
      body: FutureBuilder(
        future: _repository.getTodos(),
        builder: (ctx, snp) {
          if (snp.hasData) {
            return ListView.builder(
              itemCount: snp.data.length,
              itemBuilder: (ctx, i) {
                return ListTile(
                  title: Text(snp.data[i].title),
                );
              },
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePage(),
            ),
          );
        },
      ),
    );
  }
}
