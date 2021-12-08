// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  late TextEditingController _dateController;

  final String boxName = "todos";
  late IHiveBoxManager todoModelManager;

  DateTime _date = DateTime.now();
  final DateFormat _dateFormatter = DateFormat("MMM dd, yyyy");

  late int priority;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _dateController = TextEditingController();
    todoModelManager = TodoModelManager(boxName);

    _dateController.text = _dateFormatter.format(_date);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
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
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                readOnly: true,
                controller: _dateController,
                onTap: _handleDatePicker,
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Priority", style: TextStyle(fontSize: 20)),
                  PriorityButton(
                      name: "Low",
                      color: Colors.red[300],
                      setPriority: () => priority = 1),
                  PriorityButton(
                      name: "Medium",
                      color: Colors.yellow[300],
                      setPriority: () => priority = 2),
                  PriorityButton(
                      name: "High",
                      color: Colors.green[300],
                      setPriority: () => priority = 3),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                todoModelManager.addItem(
                  TodoModel(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    dateTime: _date,
                    status: 0,
                    priority: priority,
                  ),
                );
                Navigator.of(context).pushNamed(AppRoutes.todoScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PriorityButton extends StatelessWidget {
  final Color? color;
  final String name;
  Function() setPriority;
  PriorityButton({
    required this.name,
    required this.color,
    required this.setPriority,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: setPriority,
      child: Container(
        width: 55,
        height: 55,
        child: Center(
            child: Text(
          name,
          style: TextStyle(fontSize: 15),
        )),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: color),
      ),
    );
  }
}
