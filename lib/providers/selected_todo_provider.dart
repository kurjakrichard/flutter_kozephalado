import 'package:flutter/material.dart';
import 'package:flutter_kozephalado/model/todo.dart';

class SelectedTodoProvider extends ChangeNotifier {
  Todo? _selectedTodo;

  Todo? get getTodo => _selectedTodo;

  void setTodo(Todo? todo) {
    _selectedTodo = todo;
    notifyListeners();
  }
}
