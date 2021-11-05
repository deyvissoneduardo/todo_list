import 'package:todo_list/app/repositories/task/task_repository.dart';
import 'package:todo_list/app/services/task/task_service.dart';

class TaskServiceImpl implements TaskService {
  final TaskRepository _taskRepository;

  TaskServiceImpl({required TaskRepository taskRepository})
      : _taskRepository = taskRepository;
  @override
  Future<void> save(DateTime dateTime, String description) =>
      _taskRepository.save(dateTime, description);
}
