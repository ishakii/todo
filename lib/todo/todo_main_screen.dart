import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/todo/todo_controller.dart';
import 'package:todo/todo/models/todo_model.dart';
import 'package:todo/todo/widgets/todo_item.dart';

import 'add_todo_screen.dart';

/// tüm görevlerin listelendiği sayfadır
class TodoMainScreen extends StatelessWidget {
  const TodoMainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TodoController(),
      builder: (TodoController c) => Scaffold(
        appBar: AppBar(
          title: Text("Görevler Listesi"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            c.todoModel = TodoModel();
            Get.to(() => AddTodoScreen());
          },
        ),
        body: Column(
          children: c.todoList
              .map((todoModel) => TodoItem(todoModel: todoModel))
              .toList(),
          // children: _todoItems(c),
        ),
      ),
    );
  }

  // List<Widget> _todoItems(TodoController c) {
  //   List<Widget> todoItemWidgetsList = [];
  //
  //   for (TodoModel todoModel in c.todoList) {
  //     Widget w = TodoItem(todoModel: todoModel);
  //
  //     todoItemWidgetsList.add(w);
  //   }
  //
  //   return todoItemWidgetsList;
  // }
}
