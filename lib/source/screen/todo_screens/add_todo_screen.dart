// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quenya/core/database/hivebox_manager.dart';
import 'package:quenya/source/database/todo/todo_model.dart';
import 'package:quenya/source/database/todo/todo_model_manager.dart';
import 'package:quenya/source/navigation/routes.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  final String boxName = "todos";
  late IHiveBoxManager todoModelManager;

  DateTime _date = DateTime.now();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    todoModelManager = TodoModelManager(boxName);
    //_noteModel=NoteModel(description: '', title: '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: _descriptionController,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              todoModelManager.addItem(
                TodoModel(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  dateTime: DateTime.now(),
                  status: 1,
                  priority: 3,
                ),
              );

              Navigator.of(context).pushNamed(AppRoutes.todoScreen);
            },
          ),
        ],
      ),
    );
  }
}
