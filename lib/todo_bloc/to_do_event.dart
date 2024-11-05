part of 'to_do_bloc.dart';

abstract class ToDoEvent extends Equatable {
  const ToDoEvent();
  @override
  List<Object?> get props => [];
}

class ToDoStart extends ToDoEvent {}

class ToDoAdded extends ToDoEvent {
  final ToDo? todo;
  const ToDoAdded(this.todo);
}

class ToDoRemoved extends ToDoEvent {
  final ToDo? todo;
  const ToDoRemoved(this.todo);
}

class ToDoAltered extends ToDoEvent {
  final int index;
  const ToDoAltered(this.index);
}
