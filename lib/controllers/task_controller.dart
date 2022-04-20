import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/models/task.dart';

class TaskController extends GetxController {
  final RxList taskList = [].obs;

//This function add data to database
  Future<int> addTask({required Task task}) {
    return DBHelper.insert(task);
  }

  //This function gets data from database
  Future<void> getTasks() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

//This function deletes data from data base
  void deleteTasks(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  //This function deletes the whole task
  void deleteAllTasks() async {
    await DBHelper.deleteAll();
    getTasks();
  }

  //This function update the tasks from to completed
  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
