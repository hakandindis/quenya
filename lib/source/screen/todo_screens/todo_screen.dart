// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quenya/core/database/hivebox_manager.dart';
import 'package:quenya/source/database/todo/todo_model.dart';
import 'package:quenya/source/database/todo/todo_model_manager.dart';
import 'package:quenya/source/navigation/routes.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final String boxName = "todos";
  late IHiveBoxManager todoModelManager;

  @override
  void initState() {
    todoModelManager = TodoModelManager(boxName);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.homeScreen);
            },
            icon: Icon(Icons.home),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addTodoScreen);
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<TodoModel>(boxName).listenable(),
        builder: (BuildContext context, Box<TodoModel> todoBox, _) {
          if (todoBox.values.isEmpty) {
            return Center(
              child: Text("No Data"),
            );
          }

          return ListView.builder(
            itemCount: todoBox.length,
            itemBuilder: (BuildContext context, int index) {
              final todoModel = todoModelManager.readItem(index);
              return ListTile(
                title: Text(todoModel!.title),
                subtitle: Text(todoModel.description),
                trailing: Text(todoModel.dateTime.toIso8601String()),
                leading: Text(todoModel.status.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
