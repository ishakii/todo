import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo/todo/models/todo_model.dart';

import 'constants.dart';

class TodoController extends GetxController {
  /// Tüm todoları tutan listedir.
  List<TodoModel> todoList = [];

  /// Hem güncellenecek, hem oluştuuralan to do nesnesini tutar.
  TodoModel todoModel;

  @override
  void onInit() {
    // Lokal hafızadakini tüm todoların olduğu listeye ekler.
    var box = Hive.box(todoBox);

    final List<MapEntry> gelenTumTodolar = box.toMap().entries.toList();

    if (gelenTumTodolar != null) {
      print(gelenTumTodolar.first);

      todoList = gelenTumTodolar
          .map((e) => TodoModel.fromMap(Map<String, dynamic>.from(e.value)))
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
  createTodo() {
    todoModel.createdAt = DateTime.now().millisecondsSinceEpoch;

    todoList.add(todoModel);

    // Lokal hafızaya to do ekler
    var box = Hive.box(todoBox);

    // 2b
    final Map entries = todoList.fold(
      {},
      (previousValue, element) =>
          previousValue[element.createdAt] = element.toMap(),
    );

    box.putAll(entries);

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

  /// Tüm todoların olduğu listeyi günceller
  editTodo() {
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

// 1- todoBox aç
// 2a- map{ key: value} value = todoListesi
// 2b- map{key: value} todolist içindeki herbir todoModel için map oluşturma

// 2a
// Map<String, List<TodoModel>> map = {
//   todoBoxKey: [
//     TodoModel(),
//     TodoModel(),
//   ],
// };

// 2b
// Map<String, Map<String, dynamic>> map2 = {
//   "1": {
//     "item": "Elma",
//     "isCompleted": true,
//     "createdAt": 1,
//   },
//   "2": {
//     "item": "Elma",
//     "isCompleted": true,
//     "createdAt": 2,
//   },
// };

//2a
// box.put(
//   todoBoxKey,
//   todoList.map((todo) => todo.toMap()).toList(),
// );

// Map<String, String> m2 = {
//   "TR": "Türkiye",
//   "DE": "Almanya",
// };
//
// m2["ES"] = "İspanya";
