
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:today_task/db_task/task_entity.dart';

class DBTask extends GetxService {
  late Database dbBase;

  Future<DBTask> init() async {
    await createTaskDB();
    return this;
  }

  createTaskDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'task.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await createTaskTable(db);
        });
  }

  createTaskTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS task (id INTEGER PRIMARY KEY, createdTime TEXT, image  BLOB, name TEXT, taskTime TEXT, bgType INTEGER)');
  }

  insertTask(TaskEntity entity) async {
    final id = await dbBase.insert('task', {
      'createdTime': entity.createdTime.toIso8601String(),
      'name': entity.name,
      'taskTime': entity.taskTime.toIso8601String(),
      'bgType': entity.bgType,
    });
    return id;
  }

  deleteTask(int id) async {
    await dbBase.delete('task', where: 'id = ?', whereArgs: [id]);
  }

  cleanAllData() async {
    await dbBase.delete('task');
  }

  Future<List<TaskEntity>> getTaskAllData() async {
    var result = await dbBase.query('task', orderBy: 'taskTime DESC');
    return result.map((e) => TaskEntity.fromJson(e)).toList();
  }
}
