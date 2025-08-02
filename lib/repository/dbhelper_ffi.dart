import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
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
    sqfliteFfiInit();
    final DatabaseFactory databaseFactory = databaseFactoryFfi;
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    String dbPath = path.join(appDocumentsDir.path, "$dbName.db");

    return await databaseFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
      ),
    );
  }

  // This creates tables in our database.
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $table (
        id INTEGER PRIMARY KEY,
        todo TEXT,
        description TEXT
      )
    ''');
  }

  // Select Operation: Get todo by id
  @override
  Future<Todo> select(int id) async {
    final db = await _initialDatabase();
    List<Map<String, dynamic>> resultSet =
        await db.rawQuery("""SELECT * FROM $table WHERE id = $id""");
    /*  List<Map<String, dynamic>> resultSet =
        await db.query(table, where: 'id = ?', whereArgs: [id], limit: 1);*/
    return Todo.fromJson(resultSet[0]);
  }

  // Select Operation: Get all todos
  @override
  Future<List<Todo>> selectAll() async {
    final db = await _initialDatabase();
    List<Map<String, dynamic>> resultSet =
        await db.rawQuery("""SELECT * FROM $table """);
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
  @override
  Future<int> insert(Todo todo) async {
    final db = await _initialDatabase();
    return await db.insert(table, todo.toJson());
  }

  // Update Operation: Update todo
  @override
  Future<int> update(Todo todo) async {
    final db = await _initialDatabase();
    return await db
        .update(table, todo.toJson(), where: 'id = ?', whereArgs: [todo.id]);
  }

  // Delete Operation: Delete todo from database
  @override
  Future<int> delete(int id) async {
    final db = await _initialDatabase();
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
