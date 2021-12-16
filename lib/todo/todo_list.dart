import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/todo/todo_controller.dart';
import 'package:todo/todo/widgets/todo_item.dart';

import 'add_todo.dart';

/// tüm görevlerin listelendiği sayfadır
class TodoListScreen extends StatelessWidget {
  const TodoListScreen({Key key}) : super(key: key);

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
          onPressed: () => Get.to(() => AddTodo()),
        ),
        body: Column(
          children: c.todoList
              .map((todoModel) => TodoItem(todoModel: todoModel))
              .toList(),
        ),
      ),
    );
  }
}
