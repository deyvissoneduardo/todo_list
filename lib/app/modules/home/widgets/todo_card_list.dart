import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_list/app/core/ui/theme_extensions.dart';
import 'package:todo_list/app/models/task_filter_enum.dart';
import 'package:todo_list/app/models/total_tasks_model.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';

class TodoCardList extends StatelessWidget {
  final String label;
  final TaskFilterEnum taskFilter;
  final TotalTasksModel? totalTasksModel;
  final bool selected;
  const TodoCardList({
    Key? key,
    required this.label,
    required this.taskFilter,
    this.totalTasksModel,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<HomeController>().findTasks(filter: taskFilter),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 120,
          maxWidth: 150,
        ),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: selected ? context.primaryColor : Colors.white,
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(.8),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${totalTasksModel?.totalTask ?? 0} TASKS',
              style: context.titleStyle.copyWith(
                fontSize: 10,
                color: selected ? Colors.white : Colors.grey,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
            TweenAnimationBuilder<double>(
                duration: const Duration(seconds: 1),
                tween: Tween(
                  begin: 0.0,
                  end: _getPercentFinish(),
                ),
                builder: (context, value, child) {
                  return LinearProgressIndicator(
                    backgroundColor: selected
                        ? context.primaryColorLight
                        : Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      selected ? Colors.white : context.primaryColor,
                    ),
                    value: value,
                  );
                })
          ],
        ),
      ),
    );
  }

  double _getPercentFinish() {
    final total = totalTasksModel?.totalTask ?? 0;
    final totalFinish = totalTasksModel?.totalTaskFinish ?? 0.1;

    if (total == 0) {
      return 0.0;
    }
    final percent = (totalFinish * 100) / total;
    return percent / 100;
  }
}
