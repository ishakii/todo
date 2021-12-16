class TodoModel {
  // Görev tamamlandı mı
  bool isCompleted;

  // Görevin ismi
  String item;

  // Görevin tarihi
  int createdAt;

  TodoModel({
    this.isCompleted = false,
    this.item,
    this.createdAt,
  });

  // Veritabanına yazarken kullanılır.
  Map<String, dynamic> toMap() {
    return {
      'isCompleted': this.isCompleted,
      'item': this.item,
      'createdAt': this.createdAt,
    };
  }

  // Veritabanına okurken kullanılır.
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      isCompleted: map['isCompleted'] as bool,
      item: map['item'] as String,
      createdAt: map['createdAt'] as int,
    );
  }
}
