import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_curd_app/database/models/database_model.dart';
import 'package:sqlite_curd_app/database/models/result.dart';
import 'package:sqlite_curd_app/database/models/student.dart';

class MyDatabase {
  Future<Database> studentDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'students_db.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE students(id INTEGER PRIMARY KEY, s_name TEXT, s_age INTEGER, s_department TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<Database> resultDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'results_db.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE results(id INTEGER PRIMARY KEY, r_result TEXT, s_id INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<Database> getDatabase(DatabaseModel model) async {
    return await getDatabaseByName(model.database());
  }

  Future<Database> getDatabaseByName(String db_name) async {
    switch (db_name) {
      case 'students_db':
        return await studentDatabase();
        break;
      case 'results_db':
        return await resultDatabase();
        break;
      default:
        return null;
        break;
    }
  }

  Future<void> insert(DatabaseModel model) async {
    final Database db = await getDatabase(model);

    await db.insert(model.table(), model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    db.close();
  }

  Future<void> update(DatabaseModel model) async {
    final Database db = await getDatabase(model);

    await db.update(model.table(), model.toMap(),
        where: 'id = ?', whereArgs: [model.getId()]);

    db.close();
  }

  Future<void> delete(DatabaseModel model) async {
    final Database db = await getDatabase(model);

    await db.delete(model.table(), where: 'id = ?', whereArgs: [model.getId()]);

    db.close();
  }

  Future<List<DatabaseModel>> getAll(String table, String db_name) async {
    final Database db = await getDatabaseByName(db_name);
    final List<Map<String, dynamic>> maps = await db.query(table);
    List<DatabaseModel> models = [];
    for (var item in maps) {
      switch (table) {
        case 'students':
          models.add(Student.fromMap(item));
          break;
        case 'results':
          models.add(Result.fromMap(item));
          break;
      }
    }
    return models;
  }
}
