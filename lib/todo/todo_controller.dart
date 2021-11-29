import 'package:get/get.dart';
import 'package:todo/todo/todo_model.dart';

class TodoController extends GetxController {
  List<String> gorevlerListesi = ["Elma Al", "Portakal Al", "Karpuz Al"];

  List<TodoModel> todoList = [
    TodoModel(isCompleted: false, item: "Elma Al"),
    TodoModel(isCompleted: false, item: "Portakal Al"),
    TodoModel(isCompleted: true, item: "Muz Al"),
  ];

  TodoModel todoModel = TodoModel();
}
