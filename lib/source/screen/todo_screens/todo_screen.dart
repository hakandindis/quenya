// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_string_interpolations, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
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
      floatingActionButton: buildFloatingActionButton(context),
      body: buildScaffoldBody(),
    );
  }

  Padding buildFloatingActionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add_box_outlined,
          color: Colors.black,
          size: 40,
        ),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addTodoScreen);
        },
      ),
    );
  }

  ValueListenableBuilder<Box<TodoModel>> buildScaffoldBody() {
    return ValueListenableBuilder(
      valueListenable: Hive.box<TodoModel>(boxName).listenable(),
      builder: (BuildContext context, Box<TodoModel> todoBox, _) {
        if (todoBox.values.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Center(
                  child: Text(
                    "   NO TODO\nCREATE ONE",
                    style: TextStyle(
                      color: Colors.deepPurple[200],
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return buildListView(todoBox);
      },
    );
  }

  ListView buildListView(Box<TodoModel> todoBox) {
    return ListView.builder(
      itemCount: todoBox.length,
      itemBuilder: (BuildContext context, int index) {
        //final todoModel = todoModelManager.readItem(index);
        final todoModel = todoBox.getAt(index);

        Color? color;

        if (todoModel!.priority == 1) {
          color = Colors.green;
        } else if (todoModel.priority == 2) {
          color = Colors.yellow;
        } else {
          color = Colors.red;
        }

        return Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey[200],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildStatusIcon(todoModel, todoBox, index),
                  buildInfoText(context, index, todoModel, color),
                  buildDateText(context, index, todoModel, color),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  IconButton buildStatusIcon(
      TodoModel todoModel, Box<TodoModel> todoBox, int index) {
    return IconButton(
      //color: todoModel.status == 1 ? Colors.blue : Colors.red,
      color: Colors.blue,
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
    );
  }

  GestureDetector buildInfoText(
      BuildContext context, int index, TodoModel todoModel, Color? color) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SelectedTodoScreen(index: index),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(todoModel.title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(todoModel.description,
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic)),
          ),
        ],
      ),
    );
  }

  GestureDetector buildDateText(
      BuildContext context, int index, TodoModel todoModel, Color? color) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SelectedTodoScreen(index: index),
        ),
      ),
      child: Text('${_dateFormatter.format(todoModel.dateTime)}',
          style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }
}
