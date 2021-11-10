import 'package:todo_list/app/models/task_model.dart';

abstract class TaskRepository {
  Future<void> save(DateTime dateTime, String description);
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end);
  Future<void> checkOrUncheckTask(TaskModel task);
}
