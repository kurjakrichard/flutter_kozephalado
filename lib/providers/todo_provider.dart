import 'package:flutter/material.dart';
import 'package:flutter_kozephalado/model/todo.dart';

import '../repository/dbhelper_ffi.dart';
//import '../repository/dbhelper_sqflite.dart';
//import '../repository/dbhelper_sql.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];
  DBHelper dBHelper = DBHelper();

  List<Todo> get todos {
    return _todos;
  }

  void select(int id) async {
    await dBHelper.select(id);
    selectAll();
    notifyListeners();
  }

  void selectAll() async {
    _todos = await dBHelper.selectAll();
    notifyListeners();
  }

  void insert(Todo todo) {
    dBHelper.insert(todo);
    selectAll();
    notifyListeners();
  }

  void update(Todo todo) {
    dBHelper.update(todo);
    selectAll();
    notifyListeners();
  }

  void delete(int id) {
    dBHelper.delete(id);
    selectAll();
    notifyListeners();
  }
}
