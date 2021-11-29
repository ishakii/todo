class TodoModel {
  bool isCompleted;
  String item;

  TodoModel({this.isCompleted, this.item});

  Map<String, dynamic> toMap() {
    return {
      'isCompleted': this.isCompleted,
      'item': this.item,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      isCompleted: map['isCompleted'] as bool,
      item: map['item'] as String,
    );
  }
}
