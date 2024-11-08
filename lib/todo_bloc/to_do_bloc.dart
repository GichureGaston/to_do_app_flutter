import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../data/to_do.dart';
import '../network/network_client.dart';

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
  ) async {
    emit(state.copyWith(status: ToDoStatus.loading));
    final result = await _tasksHttpClient.getTodos();

    emit(state.copyWith(todos: result, status: ToDoStatus.success));
  }

  void _onAddToDo(
    ToDoAdded event,
    Emitter<ToDoState> emit,
  ) async {
    emit(state.copyWith(status: ToDoStatus.loading));
    try {
      final result = await _tasksHttpClient.createTodo(event.todo);
      List<ToDo> temp = [];
      temp.addAll(state.todos ?? []);
      temp.add(result!);
      emit(state.copyWith(
          todos: temp.reversed.toList(), status: ToDoStatus.success));
    } catch (e) {
      log('TODOUPDATE ${e.toString()}');
      emit(state.copyWith(
        status: ToDoStatus.error,
      ));
    }
  }

  void _onRemoveToDo(
    ToDoRemoved event,
    Emitter<ToDoState> emit,
  ) async {
    emit(state.copyWith(status: ToDoStatus.loading));
    try {
      await _tasksHttpClient.deleteTodo(event.todo);
      add(ToDoStart());
    } catch (e) {
      log('TODOUPDATE ${e.toString()}');
      emit(state.copyWith(
        status: ToDoStatus.error,
      ));
    }
  }

  void _onAlterToDo(
    ToDoAltered event,
    Emitter<ToDoState> emit,
  ) async {
    emit(state.copyWith(status: ToDoStatus.loading));
    try {
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

  final _tasksHttpClient = TasksHttpClient();
}
