import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/todo/todo_controller.dart';

class AddTodoScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TodoController c = Get.find<TodoController>();

  AddTodoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          c.todoModel.item == null ? "Görev Ekle" : "Görev Düzenle",
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Kullanıcıdan veri aldığımız form wdigeti
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: c.todoModel.item,
                onSaved: (value) {
                  c.todoModel.item = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Bu alan boş bırakılamaz";
                  } else {
                    // Eğer hata yoksa null gönder.
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: "Görev Adı",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
            // Kaydet/Güncelle butonu
            TextButton(
              onPressed: _checkForm,
              child: Text(
                c.todoModel.item == null ? "KAYDET" : "GÜNCELLE",
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Görevi, geçerliliğini kontrol ediyor.
  _checkForm() {
    // Form geçerlilik kontrolü yap.
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      // kaydetmeye/Güncellemeye başla
      c.todoModel.createdAt == null ? c.createTodo() : c.updateTodo();
    } else {
      Get.snackbar("Hata", "Lütfen form hatalarını düzeltin");
    }
  }
}
