import 'package:flutter/material.dart';
import 'package:flutter_kozephalado/model/todo.dart';
import 'package:provider/provider.dart';
import '../providers/selected_todo_provider.dart';
import '../providers/todo_provider.dart';

class ManageTodo extends StatefulWidget {
  const ManageTodo({super.key, required this.title});
  final String title;
  @override
  State<ManageTodo> createState() => _ManageTodoState();
}

class _ManageTodoState extends State<ManageTodo> {
  Todo? todo;
  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _todoController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Todo? oldTodo;
    widget.title == 'Update todo'
        ? oldTodo = context.read<SelectedTodoProvider>().getTodo
        : null;
    _todoController.text = oldTodo?.todo ?? '';
    _descriptionController.text = oldTodo?.description ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _todoController,
                onChanged: (value) {
                  debugPrint('Todo változott');
                },
                decoration: InputDecoration(
                  labelText: 'Todo',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _descriptionController,
                onChanged: (value) {
                  debugPrint('Description változott');
                },
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        'Save',
                      ),
                      onPressed: () {
                        if (oldTodo == null) {
                          Todo todo = Todo(
                              todo: _todoController.text,
                              description: _descriptionController.text);
                          context.read<TodoProvider>().insert(todo);
                        } else {
                          Todo todo = oldTodo.copyWith(
                              todo: _todoController.text,
                              description: _descriptionController.text);
                          todo != oldTodo
                              ? context.read<TodoProvider>().update(todo)
                              : null;
                        }
                        debugPrint('Save button clicked!');
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        'Mégse',
                      ),
                      onPressed: () {
                        debugPrint('Mégse button clicked!');
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
