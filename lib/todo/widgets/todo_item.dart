import 'package:flutter/material.dart';
import 'package:todo/todo/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todoModel;

  const TodoItem({Key key, this.todoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      color: Colors.yellowAccent.shade100,
      child: ListTile(
        leading: Icon(
          todoModel.isCompleted
              ? Icons.check_box
              : Icons.check_box_outline_blank,
        ),
        title: Text(todoModel.item),
      ),
    );
  }
}
