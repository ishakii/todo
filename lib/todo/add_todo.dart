import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/todo/todo_controller.dart';

class AddTodo extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final c = Get.find<TodoController>();

  AddTodo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Görevler Ekle"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // Kullanıcıdan veri aldığımız ekran
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onSaved: (value) {
                  c.todoModel.item = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Bu alan boş bırakılamaz";
                  } else {
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
              onPressed: _saveTodo,
              child: Text("KAYDET"),
            )
          ],
        ),
      ),
    );
  }

  _saveTodo() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // kaydetmeye başla
    } else {
      Get.snackbar("Hata", "Lütfen form hatalarını düzeltin");
    }
  }
}
