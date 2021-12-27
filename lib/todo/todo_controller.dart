import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo/todo/models/todo_model.dart';

import 'constants.dart';

class TodoController extends GetxController {
  /// Tüm todoları tutan listedir.
  List<TodoModel> todoList = [];

  /// Hem güncellenecek, hem oluşturalan to do nesnesini tutar.
  TodoModel todoModel;

  Box box;

  @override
  void onInit() {
    // Lokal hafızadakini tüm todoların olduğu listeye ekler.
    box = Hive.box(todoBox);

    _getAllTodos();

    super.onInit();
  }

  _getAllTodos() {
    final List<MapEntry> gelenTumTodolar = box?.toMap()?.entries?.toList();

    if (gelenTumTodolar.isNotEmpty) {
      // print(gelenTumTodolar.first);
      gelenTumTodolar.forEach((e) => print(e));
      print(gelenTumTodolar.length);

      todoList = gelenTumTodolar
          .map((e) => TodoModel.fromMap(Map<String, dynamic>.from(e.value)))
          .toList();

      // To do ları sırala
      _todolariSirala();
    }
  }

  /// Tüm toodların olduğu listeye yeni bir todos ekler.
  createTodo() {
    todoModel.createdAt = DateTime.now().millisecondsSinceEpoch;

    todoList.add(todoModel);

    // lokal hafızaya kaydet
    box.put(todoModel.createdAt.toString(), todoModel.toMap());

    // To do ları sırala
    _todolariSirala();

    // Kullanıcı arayüzünü yenile
    update();

    // Geri dön
    Get.back();

    Get.snackbar(
      "Başarılı",
      "Görev listesine ekleme başarılı",
    );
  }

  /// görevleri sıralar
  _todolariSirala() {
    todoList
      ..sort((a, b) {
        if (a.isCompleted == true) {
          return 1;
        } else {
          return -1;
        }
      });
  }

  // _saveData() {
  //   // lokal hafızadaki yeri tanımla
  //   var box = Hive.box(todoBox);
  //
  //   // Kaydetceğimiz veriyi hazırla
  //   // final Map<String, dynamic> entries = todoList.fold(
  //   //   <String, dynamic>{},
  //   //   (previousValue, element) =>
  //   //       previousValue[element.createdAt.toString()] = element.toMap(),
  //   // );
  //   // print("entries" + entries.toString());
  //   // print("entries length " + entries.length.toString());
  //
  //   Map<String, dynamic> map = {};
  //   for (TodoModel todoModel in todoList) {
  //     map[todoModel.createdAt.toString()] = todoModel.toMap();
  //   }
  //   print("map" + map.toString());
  //   print("map length " + map.length.toString());
  //
  //   // veriyi lokal hafızaya kaydet
  //   box.clear();
  //   box.putAll(map);
  // }

  deleteTodo(TodoModel todoModel) {
    todoList.remove(todoModel);

    box.delete(todoModel.createdAt.toString());

    // Kullanıcı arayüzünü yenile
    update();

    Get.snackbar("Başarılı", "Görev listesinden görev silindi");
  }

  /// görevi günceller
  updateTodo() {
    todoList.removeWhere((element) => element.createdAt == todoModel.createdAt);

    todoList.add(todoModel);

    // lokale kaydet
    box.put(todoModel.createdAt.toString(), todoModel.toMap());

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
    box.put(todoModel.createdAt.toString(), todoModel.toMap());

    _todolariSirala();

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
