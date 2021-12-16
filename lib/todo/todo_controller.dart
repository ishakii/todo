import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo/todo/todo_model.dart';

import 'constants.dart';

class TodoController extends GetxController {
  /// Tüm todoları tutan listedir.
  List<TodoModel> todoList = [];

  @override
  void onInit() {
    // Lokal hafızadakini tüm todoların olduğu listeye ekler.
    var box = Hive.box(todoBox);
    final List gelenTumTodolar = box.get(todoBoxKey);

    if (gelenTumTodolar != null) {
      todoList = gelenTumTodolar
          .map((e) => TodoModel.fromMap(Map<String, dynamic>.from(e)))
          .toList();

      final List<TodoModel> tamamlananlarListesi =
          todoList.where((element) => element.isCompleted).toList();

      todoList = todoList.where((element) => !element.isCompleted).toList();

      todoList.addAll(tamamlananlarListesi);
    }

    // TodoModel todoModel = TodoModel.fromMap(Map<String, dynamic>.from(e));
    // todoList.add(todoModel);

    super.onInit();
  }

  /// Tüm toodların olduğu listeye yeni bir todos ekler.
  addTodo(TodoModel todoModel) {
    todoList.add(todoModel);

    // Lokal hafızaya to do ekler
    var box = Hive.box(todoBox);

    box.put(
      todoBoxKey,
      todoList.map((todo) => todo.toMap()).toList(),
    );

    // Kullanıcı arayüzünü yenile
    update();

    // Geri dön
    Get.back();

    Get.snackbar("Başarılı", "Görev listesine ekleme başarılı");
  }

  deleteTodo(TodoModel todoModel) {
    todoList.remove(todoModel);

    // Lokal hafızadan da to do çıkart.
    var box = Hive.box(todoBox);

    box.put(
      todoBoxKey,
      todoList.map((todo) => todo.toMap()).toList(),
    );

    // Kullanıcı arayüzünü yenile
    update();

    Get.snackbar("Başarılı", "Görev listesinden görev silindi");
  }

  /// Tüm toodların olduğu listeyi günceller
  editTodo(TodoModel todoModel) {
    // todoList.add(todoModel);
    //
    // // Lokal hafızaya to do ekler
    // var box = Hive.box(todoBox);
    //
    // box.put(
    //   todoBoxKey,
    //   todoList.map((todo) => todo.toMap()).toList(),
    // );
    //
    // // Kullanıcı arayüzünü yenile
    // update();
    //
    // // Geri dön
    // Get.back();
    //
    // Get.snackbar("Başarılı", "Görev listesine ekleme başarılı");
  }

  tamamlandiYap(TodoModel todoModel) {
    todoList.remove(todoModel);

    todoModel.isCompleted = !todoModel.isCompleted;
    todoList.add(todoModel);

    // Lokal hafızaya to do ekler
    var box = Hive.box(todoBox);

    box.put(
      todoBoxKey,
      todoList.map((todo) => todo.toMap()).toList(),
    );

    // Kullanıcı arayüzünü yenile
    update();

    Get.snackbar(
      "Başarılı",
      todoModel.isCompleted
          ? "Yapıldı olarak kaydedildi"
          : "Yapılmadı olarak kaydedildi",
    );
  }
}
