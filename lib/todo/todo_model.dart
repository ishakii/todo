class TodoModel {
  // Görev tamamlandı mı
  bool isCompleted;

  // Görevin ismi
  String item;

  TodoModel({
    this.isCompleted = false,
    this.item,
  });

  // Veritabanına yazarken kullanılır.
  Map<String, dynamic> toMap() {
    return {
      'isCompleted': this.isCompleted,
      'item': this.item,
    };
  }

  // Veritabanına okurken kullanılır.
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      isCompleted: map['isCompleted'] as bool,
      item: map['item'] as String,
    );
  }
}
