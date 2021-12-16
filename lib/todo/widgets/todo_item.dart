import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/todo/edit_todo.dart';
import 'package:todo/todo/todo_controller.dart';
import 'package:todo/todo/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todoModel;
  final TodoController c = Get.find<TodoController>();

  TodoItem({Key key, this.todoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) {
        c.deleteTodo(todoModel);
      },
      key: ValueKey(todoModel.item),
      child: Container(
        margin: const EdgeInsets.all(10),
        color: !todoModel.isCompleted
            ? Colors.yellowAccent.shade100
            : Colors.blueGrey.shade50,
        child: ListTile(
          // Düzenleme
          onTap: () => Get.to(() => EditTodo(todoModel: todoModel)),
          leading: IconButton(
            onPressed: () {
              c.tamamlandiYap(todoModel);
            },
            icon: Icon(
              todoModel.isCompleted
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
            ),
          ),
          title: Text(
            todoModel.item,
            style: TextStyle(
                decoration:
                    todoModel.isCompleted ? TextDecoration.lineThrough : null),
          ),
        ),
      ),
    );
  }
}
