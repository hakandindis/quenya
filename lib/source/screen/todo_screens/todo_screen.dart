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
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add_box_outlined,color: Colors.black,
            size: 40,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.addTodoScreen);
          },
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<TodoModel>(boxName).listenable(),
        builder: (BuildContext context, Box<TodoModel> todoBox, _) {
          if (todoBox.values.isEmpty) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(child: Text("NO TODO, CREATE ONE",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),),
                  IconButton(onPressed: ()=>Navigator.of(context).pushNamed(AppRoutes.addTodoScreen), icon: Icon(Icons.add_box_outlined,size: 50,)),
                ],
              ),
            );
          }

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

              //return buildListTile(context, index, todoModel, color, todoBox);

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
        },
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
                //maxLines: 2,
                //overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(todoModel.description,
                //overflow: TextOverflow.ellipsis,
                //textDirection: TextDirection.RTL,
                //textAlign: TextAlign.justify,
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic)),
          ),
        ],
      ),
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

  Padding buildListTile(BuildContext context, int index, TodoModel todoModel,
      Color? color, Box<TodoModel> todoBox) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SelectedTodoScreen(index: index),
            ),
          ),
          tileColor: Colors.grey[200],
          title: Text(todoModel.title,
              style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          subtitle: Text(
            todoModel.description,
            style: TextStyle(
                color: color,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic),
          ),

          //trailing: Text(todoModel.dateTime.toIso8601String()),
          trailing: Text('${_dateFormatter.format(todoModel.dateTime)}',
              style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          leading: IconButton(
            color: todoModel.status == 1 ? Colors.blue : Colors.red,
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
        ),
      ),
    );
  }
}
