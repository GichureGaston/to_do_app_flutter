import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../data/to_do.dart';

part 'to_do_event.dart';
part 'to_do_state.dart';

class ToDoBloc extends HydratedBloc<ToDoEvent, ToDoState> {
  ToDoBloc() : super(const ToDoState()) {
    on<ToDoStart>(_onStarted);
    on<ToDoAdded>(_onAddToDo);
    on<ToDoRemoved>(_onRemoveToDo);
    on<ToDoAltered>(_onAlterToDo);
  }

  void _onStarted(
    ToDoStart event,
    Emitter<ToDoState> emit,
  ) {
    if (state.status == ToDoStatus.success) return;
    emit(state.copyWith(todos: state.todos, status: ToDoStatus.success));
  }

  void _onAddToDo(
    ToDoAdded event,
    Emitter<ToDoState> emit,
  ) {
    emit(state.copyWith(status: ToDoStatus.loading));
    try {
      List<ToDo> temp = [];
      temp.addAll(state.todos ?? []);
      temp.add(event.todo!);
      emit(state.copyWith(
          todos: temp.reversed.toList(), status: ToDoStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: ToDoStatus.error,
      ));
    }
  }

  void _onRemoveToDo(
    ToDoRemoved event,
    Emitter<ToDoState> emit,
  ) {
    emit(state.copyWith(status: ToDoStatus.loading));
    try {
      state.todos?.remove(event.todo);
      emit(state.copyWith(
        todos: state.todos,
        status: ToDoStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ToDoStatus.error,
      ));
    }
  }

  void _onAlterToDo(
    ToDoAltered event,
    Emitter<ToDoState> emit,
  ) {
    emit(state.copyWith(status: ToDoStatus.loading));
    try {
      state.todos?[event.index].isDone =
          !(state.todos?[event.index].isDone ?? false);
      emit(state.copyWith(todos: state.todos, status: ToDoStatus.success));
    } catch (e) {
      emit(state.copyWith(status: ToDoStatus.error));
    }
  }

  @override
  ToDoState? fromJson(Map<String, dynamic> json) {
    return ToDoState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ToDoState state) {
    return state.toJson();
  }
}
