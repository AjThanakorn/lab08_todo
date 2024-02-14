import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ToDoController extends GetxController {
  late Database _database;
  late RxList<Map<String, dynamic>> todos = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');

    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
          CREATE TABLE todo(
            id INTEGER PRIMARY KEY,
            title TEXT,
            description TEXT,
            category TEXT
          )
        ''');
        });

    await _fetchTodos();
  }

  Future<void> _fetchTodos() async {
    final List<Map<String, dynamic>> fetchedTodos = await _database.query('todo');
    todos.assignAll(fetchedTodos);
  }

  Future<void> addToDo(String title, String description, String category) async {
    await _database.insert('todo', {
      'title': title,
      'description': description,
      'category': category,
    });

    await _fetchTodos();
  }

  Future<void> updateToDo(int id, String title, String description, String category) async {
    await _database.update('todo', {
      'title': title,
      'description': description,
      'category': category,
    }, where: 'id = ?', whereArgs: [id]);

    await _fetchTodos();
  }

  Future<void> deleteToDo(int id) async {
    await _database.delete('todo', where: 'id = ?', whereArgs: [id]);

    await _fetchTodos();
  }

  @override
  void onClose() {
    _database.close();
    super.onClose();
  }
}

