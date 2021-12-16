import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/todo/todo_controller.dart';
import 'package:todo/todo/todo_model.dart';

class EditTodo extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TodoController c = Get.find<TodoController>();

  // Eklenecek to do nesnesini tutar.
  final TodoModel todoModel;

  EditTodo({Key key, this.todoModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Görev Düzenle"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Kullanıcıdan veri aldığımız form wdigeti
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: todoModel.item,
                onSaved: (value) {
                  todoModel.item = value;
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
            // Kaydet butonu
            TextButton(
              onPressed: _checkForm,
              child: Text("GÜNCELLE"),
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

      // güncellemeye başla
      c.editTodo(todoModel);
    } else {
      Get.snackbar("Hata", "Lütfen form hatalarını düzeltin");
    }
  }
}
