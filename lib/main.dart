import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todolist/bloc_observer.dart';
import 'package:todolist/home.dart';
import 'package:todolist/todo_bloc/to_do_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo App',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            background: Colors.white70,
            onBackground: Colors.black,
            primary: Colors.brown,
            onPrimary: Colors.black,
            secondary: Colors.tealAccent,
            onSecondary: Colors.white,
          ),
        ),
        home: BlocProvider<ToDoBloc>(
          create: (context) => ToDoBloc()..add(ToDoStart()),
          child: const HomeScreen(),
        ));
  }
}
