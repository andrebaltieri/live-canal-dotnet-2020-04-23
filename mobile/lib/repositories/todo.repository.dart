import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todos/models/todo-item.model.dart';
import 'package:todos/models/user.model.dart';
import 'package:todos/settings.dart';

class TodoRepository {
  Future login(UserModel model) async {
    var url = "$API_URL/v1/users/login";
    Response response = await Dio().post(
      url,
      data: model,
    );

    token = response.data["token"];
    return UserModel.fromJson(response.data["user"]);
  }

  Future create(UserModel model) async {
    var url = "$API_URL/v1/users";
    await Dio().post(
      url,
      data: model,
    );

    return;
  }

  Future<List<TodoItem>> getTodos() async {
    var url = "$API_URL/v1/todos";
    Response response = await Dio().get(
      url,
      options: Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      ),
    );
    return (response.data as List)
        .map((todos) => TodoItem.fromJson(todos))
        .toList();
  }

  Future createTask(TodoItem model) async {
    var url = "$API_URL/v1/todos";
    await Dio().post(
      url,
      data: model,
      options: Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
      ),
    );

    return;
  }
}
