import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  const Todo({this.id, required this.todo, required this.description});
  //Todo.withoutId({required this.todo, required this.description});
  const Todo.withId(
      {required this.id, required this.todo, required this.description});

  final int? id;
  final String todo;
  final String description;

  Todo.fromJson(Map<String, dynamic> res)
      : id = res['id'],
        todo = res['todo'],
        description = res['description'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['todo'] = todo;
    map['description'] = description;
    return map;
  }

  Map<String, dynamic> toJson2() {
    return <String, dynamic>{
      'id': id,
      'todo': todo,
      'description': description
    };
  }

/*
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          todo == other.todo &&
          description == other.description;

  @override
  int get hashCode => id.hashCode ^ todo.hashCode ^ description.hashCode;
*/
  @override
  List<Object?> get props {
    return [id, todo, description];
  }

  Todo copyWith({int? id, String? todo, String? description}) {
    return Todo(
        id: id ?? this.id,
        todo: todo ?? this.todo,
        description: description ?? this.description);
  }
}
