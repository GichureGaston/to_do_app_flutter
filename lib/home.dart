import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/data/to_do.dart';
import 'package:todolist/todo_bloc/to_do_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  toDoAdded(ToDo? todo) {
    context.read<ToDoBloc>().add(ToDoAdded(todo));
  }

  todoRemove(ToDo? todo) {
    context.read<ToDoBloc>().add(ToDoRemoved(todo));
  }

  alterTodo(int index) {
    context.read<ToDoBloc>().add(ToDoAltered(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              TextEditingController controller1 = TextEditingController();
              TextEditingController controller2 = TextEditingController();
              return AlertDialog(
                title: const Text('Add a Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: controller1,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      decoration: InputDecoration(
                          hintText: 'Task Title....',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ))),
                    ),
                    const SizedBox(height: 11),
                    TextField(
                      controller: controller2,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      decoration: InputDecoration(
                          hintText: 'Task Subtitle....',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ))),
                    ),
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                        onPressed: () {
                          toDoAdded(ToDo(
                            title: controller1.text,
                            subtitle: controller2.text,
                          ));
                          controller1.text = '';
                          controller2.text = '';
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.secondary),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          foregroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: const Icon(
                            Icons.check_box,
                            color: Colors.green,
                          ),
                        )),
                  )
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: Text(
          'MY TO-DO APP',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ToDoBloc, ToDoState>(builder: (context, state) {
          if (state.status == ToDoStatus.success) {
            return ListView.builder(
              itemCount: state.todos?.length,
              itemBuilder: (context, int i) {
                return Card(
                  color: Theme.of(context).colorScheme.primary,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Slidable(
                    key: const ValueKey(0),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (_) {
                            todoRemove(state.todos?[i]);
                          },
                          backgroundColor: const Color(0xFFFF0000),
                          foregroundColor: Colors.white,
                          icon: Icons.delete_rounded,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(state.todos?[i].title ?? ""),
                      subtitle: Text(state.todos?[i].subtitle ?? ''),
                      trailing: Checkbox(
                        value: state.todos?[i].isDone ?? false,
                        activeColor: Theme.of(context).colorScheme.secondary,
                        onChanged: (value) {
                          alterTodo(i);
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state.status == ToDoStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
