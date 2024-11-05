part of 'to_do_bloc.dart';

enum ToDoStatus { initial, loading, success, error }

class ToDoState extends Equatable {
  final List<ToDo>? todos;
  final ToDoStatus status;

  const ToDoState({this.todos, this.status = ToDoStatus.initial});

  ToDoState copyWith({
    ToDoStatus? status,
    List<ToDo>? todos,
  }) {
    return ToDoState(todos: todos ?? this.todos, status: status ?? this.status);
  }

  @override
  factory ToDoState.fromJson(Map<String, dynamic> json) {
    try {
      var listOfToDos = (json['todo'] as List<dynamic>)
          .map((e) => ToDo.fromJson(e as Map<String, dynamic>))
          .toList();
      return ToDoState(
          todos: listOfToDos,
          status: ToDoStatus.values.firstWhere(
              (element) => element.name.toString() == json['status']));
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'todo': todos,
      'status': status.name,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [todos, status];
}
