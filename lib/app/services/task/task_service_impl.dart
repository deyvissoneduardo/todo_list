import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/models/week_task_model.dart';
import 'package:todo_list/app/repositories/task/task_repository.dart';
import 'package:todo_list/app/services/task/task_service.dart';

class TaskServiceImpl implements TaskService {
  final TaskRepository _taskRepository;

  TaskServiceImpl({required TaskRepository taskRepository})
      : _taskRepository = taskRepository;
  @override
  Future<void> save(DateTime dateTime, String description) =>
      _taskRepository.save(dateTime, description);

  @override
  Future<List<TaskModel>> getToday() {
    return _taskRepository.findByPeriod(DateTime.now(), DateTime.now());
  }

  @override
  Future<List<TaskModel>> getTomorrow() {
    var tomorrowDate = DateTime.now().add(const Duration(days: 1));
    return _taskRepository.findByPeriod(tomorrowDate, tomorrowDate);
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    final today = DateTime.now();
    var startFilter = DateTime(today.year, today.month, today.day, 0, 0, 0);
    DateTime endFilter;
    if (startFilter.weekday != DateTime.monday) {
      startFilter =
          startFilter.subtract(Duration(days: (startFilter.weekday - 1)));
    }
    endFilter = startFilter.add(const Duration(days: 7));
    final tasks = await _taskRepository.findByPeriod(startFilter, endFilter);
    return WeekTaskModel(
      startDate: startFilter,
      endDate: endFilter,
      tasks: tasks,
    );
  }
}
