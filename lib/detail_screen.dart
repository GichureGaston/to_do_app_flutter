import 'package:flutter/material.dart';
import 'package:todolist/data/to_do.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, this.toDo});
  final ToDo? toDo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: Text(toDo?.title ?? ''),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            children: [
              Text(
                toDo?.description ?? '',
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
