import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todolist/data/to_do.dart';
import 'package:todolist/network/constants.dart';

class TasksHttpClient {
  var client = http.Client();

  Future<ToDo>? createTodo(ToDo? todo) async {
    var url = Uri.https(ApiPaths.baseUrl, ApiPaths.taskList);
    var response = await http.post(url, body: todo?.toJson());
    return ToDo.fromJson(jsonDecode(response.body));
  }

  Future<ToDo>? updateTodo(ToDo? todo) async {
    var url = Uri.https(ApiPaths.baseUrl, '${ApiPaths.tasks}/${todo?.id}/');
    var response = await http.patch(url, body: todo?.toJson());
    return ToDo.fromJson(jsonDecode(response.body));
  }

  Future<ToDo>? getTodo(int? id) async {
    var url = Uri.https(ApiPaths.baseUrl, '${ApiPaths.tasks}/$id/');
    var response = await http.get(url);
    return ToDo.fromJson(jsonDecode(response.body));
  }

  // Future<List<ToDo>>? getTodos() async {
  //   var url = Uri.https(ApiPaths.baseUrl, ApiPaths.taskList);
  //   var response = await http.get(url);
  //   return json
  //       .decode(response.body)
  //       .map((data) => ToDo.fromJson(data))
  //       .toList();
  // }
  Future<List<ToDo>> getTodos() async {
    var url = Uri.https(ApiPaths.baseUrl, ApiPaths.taskList);
    var response = await http.get(url);

    // Decode the response and cast it to a list of maps
    List<dynamic> data = json.decode(response.body);

    // Map each item to ToDo and return the list
    return data
        .map((item) => ToDo.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void>? deleteTodo(ToDo? todo) async {
    var url = Uri.https(ApiPaths.baseUrl, '${ApiPaths.tasks}/${todo?.id}/');
    await http.delete(url);
    return;
  }
}
