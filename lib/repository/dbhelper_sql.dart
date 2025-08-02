import 'dart:io';
import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import '../model/todo.dart';

class DBHelper {
  static const dbName = 'todo';
  static const table = 'todo';
  static DBHelper? _databaseHelper;
  static Database? _database;

  DBHelper.createInstance();

  Future<Database> get database async {
    _database ??= await _initialDatabase();
    return _database!;
  }

  factory DBHelper() {
    _databaseHelper ??= DBHelper.createInstance();
    return _databaseHelper!;
  }

  Future<Database> _initialDatabase() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    String dbPath = path.join(appDocumentsDir.path, "$dbName.db");

    _database = sqlite3.open(
      dbPath,
    );
    await _onCreate(_database!);
    return _database!;
  }

  // This creates tables in our database.
  Future<void> _onCreate(Database db) async {
    db.execute('''
      CREATE TABLE IF NOT EXISTS $table (
        id INTEGER PRIMARY KEY,
        todo TEXT,
        description TEXT
      )
    ''');
  }

  // Select Operation: Get todo by id
  Future<Todo> select(int id) async {
    final Database db = await _initialDatabase();
    List<Map<String, dynamic>> resultSet =
        db.select("""SELECT * FROM $table WHERE id = $id""");
    /*  List<Map<String, dynamic>> resultSet =
        await db.query(table, where: 'id = ?', whereArgs: [id], limit: 1);*/
    return Todo.fromJson(resultSet[0]);
  }

  // Select Operation: Get all todos
  Future<List<Todo>> selectAll() async {
    final db = await _initialDatabase();
    List<Map<String, dynamic>> resultSet =
        db.select("""SELECT * FROM $table """);
    /*  List<Map<String, dynamic>> resultSet =
        await db.query(table, where: 'id = ?', whereArgs: [id]);*/
    return resultSet.map((e) => Todo.fromJson(e)).toList();
    /*List<Todo> todos = <Todo>[];
    for (var item in resultSet) {
      Todo todo = Todo.fromJson(item);
      todos.add(todo);
    }
    return todos;*/
  }

  // Insert Operation: Insert new todo
  void insert(Todo todo) async {
    final db = await _initialDatabase();
    final stmt =
        db.prepare('INSERT INTO $table (todo, description) VALUES (?, ?)');
    return stmt.execute([todo.todo, todo.description]);
  }

  // Update Operation: Update todo
  void update(Todo todo) async {
    final db = await _initialDatabase();
    return db.execute(
        '''UPDATE $table SET todo=?, description=? WHERE id = ?''',
        [todo.todo, todo.description, todo.id]);
  }

  // Delete Operation: Delete todo from database
  void delete(int id) async {
    final db = await _initialDatabase();
    return db.execute('DELETE FROM $table WHERE id = $id');
  }
}
