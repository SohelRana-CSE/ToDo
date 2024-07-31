import 'dart:developer';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_app/models/todo.model.dart';

class TodoRepository {

  Future<List<Todo>> getTodos({
    required Database database,
  }) async {
    final datas = await database.rawQuery('SELECT * FROM todo');
    List<Todo> todos = [];
    for (var item in datas) {
      todos.add(Todo(item['id'] as int, item['name'] as String));
    }
    return todos;
  }

  Future<dynamic> addTodo({
    required Database database,
    required String text,
  }) async {
    return await database.transaction((txn) async {
      await txn.rawInsert("INSERT INTO todo (name) VALUES ('$text')");
    });
  }

  Future<dynamic> removeTodo({
    required Database database,
    required int id,
  }) async {
    return await database.transaction((txn) async {
      await txn.rawDelete('DELETE FROM todo where id = $id');
    });
  }
}