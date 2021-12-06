import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo/todo/todo_model.dart';

class TodoController extends GetxController {
  /// Tüm todoları tutan listedir.
  List<TodoModel> todoList = [];

  @override
  void onInit() {
    // Lokal hafızadakini tüm todoların olduğu listeye ekler.
    var box = Hive.box('todoList');
    final List gelenTumTodolar = box.get('allTodos');

    if (gelenTumTodolar != null) {
      todoList = gelenTumTodolar
          .map((e) => TodoModel.fromMap(Map<String, dynamic>.from(e)))
          .toList();
    }

    // TodoModel todoModel = TodoModel.fromMap(Map<String, dynamic>.from(e));
    // todoList.add(todoModel);

    super.onInit();
  }

  /// Tüm toodların olduğu listeye yeni bir todos ekler.
  addTodo(TodoModel todoModel) {
    todoList.add(todoModel);

    // Lokal hafızaya to do ekler
    var box = Hive.box('todoList');
    box.put(
      'allTodos',
      todoList.map((todo) => todo.toMap()).toList(),
    );

    // Kullanıcı arayüzünü yenile
    update();

    // Geri dön
    Get.back();

    Get.snackbar("Başarılı", "Görev listesine ekleme başarılı");
  }
}
