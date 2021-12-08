// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quenya/core/database/hivebox_manager.dart';
import 'package:quenya/source/database/todo/todo_model.dart';
import 'package:quenya/source/database/todo/todo_model_manager.dart';
import 'package:quenya/source/navigation/routes.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quenya/source/screen/todo_screens/selected_todo_screen.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final String boxName = "todos";
  late IHiveBoxManager todoModelManager;

  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

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
              //final todoModel = todoModelManager.readItem(index);
              final todoModel = todoBox.getAt(index);

              Color? color;

              if (todoModel!.priority == 1) {
                color = Colors.red[300];
              } else if (todoModel.priority == 2) {
                color = Colors.yellow[300];
              } else {
                color = Colors.green[300];
              }

              return ListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SelectedTodoScreen(index: index),
                  ),
                ),
                tileColor: color,
                title: Text(todoModel.title),
                subtitle: Text(todoModel.description),
                //trailing: Text(todoModel.dateTime.toIso8601String()),
                trailing: Text('${_dateFormatter.format(todoModel.dateTime)}'),
                //leading: todoModel.status == 1
                //  ? Icon(Icons.done_all_outlined)
                //: Icon(Icons.do_not_disturb_on_outlined),
                leading: IconButton(
                  onPressed: () {
                    if (todoModel.status == 0) {
                      todoBox.putAt(
                        index,
                        TodoModel(
                          title: todoModel.title,
                          description: todoModel.description,
                          dateTime: todoModel.dateTime,
                          status: 1,
                          priority: todoModel.priority,
                        ),
                      );
                    } else {
                      todoBox.putAt(
                        index,
                        TodoModel(
                          title: todoModel.title,
                          description: todoModel.description,
                          dateTime: todoModel.dateTime,
                          status: 0,
                          priority: todoModel.priority,
                        ),
                      );
                    }
                  },
                  icon: todoModel.status == 1
                      ? Icon(Icons.done_all_outlined)
                      : Icon(Icons.do_not_disturb_on_outlined),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
