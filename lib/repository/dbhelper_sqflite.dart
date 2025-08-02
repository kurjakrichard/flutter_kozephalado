import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import '../model/todo.dart';

class DBHelper {
  static String dbName = 'todo';
  static String table = 'todo';

  static Future<Database> _initDatabase() async {
    // final String dbPath = await getDatabasesPath();
    final Directory dbPath = await getApplicationDocumentsDirectory();

    return await openDatabase(
      path.join(dbPath.path, '$dbName.db'),
      onCreate: (database, version) {
        database.execute('''
      CREATE TABLE IF NOT EXISTS $table (
        id INTEGER PRIMARY KEY,
        todo TEXT,
        description TEXT
      )
    ''');
      },
      version: 1,
    );
  }

  // Select Operation: Get todo by id
  @override
  Future<Todo> select(int id) async {
    final Database db = await DBHelper._initDatabase();
    final List<Map<String, Object?>> resultSet =
        await db.query(table, where: 'id = ?', whereArgs: [id]);
    return resultSet.map((e) => Todo.fromJson(e)).toList()[0];
  }

  // Select Operation: Get all todos
  @override
  Future<List<Todo>> selectAll() async {
    final Database db = await DBHelper._initDatabase();
    final List<Map<String, Object?>> resultSet = await db.query(table);
    return resultSet.map((e) => Todo.fromJson(e)).toList();
  }

  // Insert Operation: Insert new todo
  @override
  Future<int> insert(Todo todo) async {
    final Database db = await DBHelper._initDatabase();
    return await db.insert(table, todo.toJson());
  }

  // Update Operation: Update todo
  @override
  Future<int> update(Todo todo) async {
    final Database db = await DBHelper._initDatabase();
    return await db
        .update(table, todo.toJson(), where: 'id = ?', whereArgs: [todo.id]);
  }

  // Delete Operation: Delete todo from database
  @override
  Future<int> delete(int id) async {
    final Database db = await DBHelper._initDatabase();
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
