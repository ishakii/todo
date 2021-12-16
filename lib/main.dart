import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/todo/todo_list.dart';

import 'todo/constants.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox(todoBox);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: TodoListScreen(),
    );
  }
}

// Hafataya yapılacaklar
// tamamlandı olarak işaretleme yapılacak
// silme, güncelleme işlemleri

// firebase kaydetme yapılacak
// auth eklenecek
