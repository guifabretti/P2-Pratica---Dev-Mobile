import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/tarefa.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _db;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final path = join(
      await getDatabasesPath(),
      'tarefas_202310286.db',
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tarefas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        descricao TEXT NOT NULL,
        prioridade INTEGER NOT NULL,
        criadoEm TEXT NOT NULL,
        indiceRelevancia REAL NOT NULL
      )
    ''');
  }

}
