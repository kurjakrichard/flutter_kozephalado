import 'package:flutter/material.dart';
import 'package:flutter_kozephalado/model/todo.dart';
import 'package:flutter_kozephalado/providers/todo_provider.dart';
import 'package:provider/provider.dart';
import '../providers/selected_todo_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerNavigation(context),
      appBar: AppBar(
        title: Text(title),
      ),
      body: getTodos(context),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              navigatetoDetail(context, '/insertTodo');
            },
            tooltip: 'Add todo',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Widget drawerNavigation(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Homepage'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              }),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings', arguments: 'Settings');
            },
          ),
        ],
      ),
    );
  }

  Widget getTodos(BuildContext context) {
    List<Todo> todoList = context.watch<TodoProvider>().todos;
    return todoList.isEmpty
        ? Center(
            child: Text('Nincs todo'),
          )
        : ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (BuildContext context, int position) {
              return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                      title: Text(
                        todoList[position].todo,
                      ),
                      subtitle: Text(todoList[position].description),
                      trailing: GestureDetector(
                        child: const Icon(
                          Icons.delete,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          debugPrint('Delete icon clicked');
                          context
                              .read<TodoProvider>()
                              .delete(todoList[position].id!);
                        },
                      ),
                      onTap: () {
                        debugPrint('Edit todo ${todoList[position].todo}');
                        context
                            .read<SelectedTodoProvider>()
                            .setTodo(todoList[position]);

                        navigatetoDetail(context, '/updateTodo');
                      }));
            });
  }

  void navigatetoDetail(BuildContext context, String route) async {
    await Navigator.pushNamed(
      context,
      route,
    );
  }
}
