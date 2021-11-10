import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/app/models/task_model.dart';
import 'package:todo_list/app/modules/home/home_controller.dart';

class Task extends StatelessWidget {
  final TaskModel _model;
  final dateFormat = DateFormat('dd/MM/y');
  Task({Key? key, required TaskModel model})
      : _model = model,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.grey),
        ],
      ),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1),
          ),
          leading: Checkbox(
            value: _model.finished,
            onChanged: (value) =>
                context.read<HomeController>().checkOrUncheckTask(_model),
          ),
          title: Text(
            _model.description,
            style: _model.finished
                ? const TextStyle(decoration: TextDecoration.lineThrough)
                : null,
          ),
          subtitle: Text(
            dateFormat.format(_model.dateTime),
            style: _model.finished
                ? const TextStyle(decoration: TextDecoration.lineThrough)
                : null,
          ),
        ),
      ),
    );
  }
}
