import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  const Task({Key? key}) : super(key: key);

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
            value: true,
            onChanged: (value) {},
          ),
          title: const Text(
            'Descrição da task',
            style: TextStyle(decoration: TextDecoration.lineThrough),
          ),
          subtitle: const Text(
            '01/01/1970',
            style: TextStyle(decoration: TextDecoration.lineThrough),
          ),
        ),
      ),
    );
  }
}
