import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/task.dart';

class DBHelper {
  static Database? db;
  static const int version = 1;
  static const String tableName = 'tasks';

  static Future initDb() async {
    if (db != null) {
      debugPrint('db is not null');
      return;
    } else {
      try {
        String path = await getDatabasesPath() + 'task.db';
        debugPrint('database path created');
        db = await openDatabase(path, version: version,
            onCreate: (Database db, int version) async {
          // When creating the db, create the table
              debugPrint('Creating new database');
          await db.execute(
            'CREATE TABLE $tableName ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'title STRING, note TEXT, date STRING,  '
            'startTime STRING, endTime STRING,  '
            'remind INTEGER, repeat STRING, '
            'color INTEGER, '
            'isCompleted INTEGER)',
          );
        });
        debugPrint('Database Created');
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<int> insert(Task task ) async {
    print('insert Function is called');
    return await db!.insert(tableName, task.toJson());
  }

  static Future<int> delete(Task task) async { //delete function here will delete the whole table that's why we need where, and whereArgs [task.id]
    print('delete Function is called');
    return await db!.delete(tableName, where: 'id  = ?', whereArgs: [task.id]);
  }


  static Future<int> deleteAll() async { //delete function here will delete the whole table that's why we need where, and whereArgs [task.id]
    print('deleteAll Function is called');
    return await db!.delete(tableName);
  }

static Future<List<Map<String,dynamic>>> query() async { //query fetch all data from data base
    print('query Function is called');
    return await db!.query(tableName);
  }


  static Future<int> update(int id) async { //the update function will update the whole table so we have to use rawUpdate to update one item
    print('rawUpdate Function is called');
    return await db!.rawUpdate('''  
    UPDATE  tasks
    SET isCompleted = ?
    WHERE id = ?  
    ''', [1, id]);
  }
}
