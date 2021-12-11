// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quenya/core/database/hivebox_manager.dart';
import 'package:quenya/source/database/todo/todo_model.dart';
import 'package:quenya/source/database/todo/todo_model_manager.dart';

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
    priority = 2;
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
      //appBar: AppBar(),
      body: SingleChildScrollView(
        controller: ScrollController(initialScrollOffset: 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: IconButton(
                  onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.arrow_back_ios_new),),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: Colors.blue,
                minLines: 1,
                maxLines: 3,
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  hintText: "Something",
                  labelText: "Title",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                keyboardType: TextInputType.text,
                cursorColor: Colors.blue,
                minLines: 1,
                maxLines: 3,
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: "Something",
                  labelText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                readOnly: true,
                controller: _dateController,
                onTap: _handleDatePicker,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Priority", style: TextStyle(fontSize: 20)),
                  PriorityButton(
                    color: Colors.green,
                    setPriority: () => priority = 1,
                    icon: Icon(Icons.looks_one_outlined),
                  ),
                  PriorityButton(
                    color: Colors.yellow,
                    setPriority: () => priority = 2,
                    icon: Icon(Icons.looks_two_outlined),
                  ),
                  PriorityButton(
                    color: Colors.red,
                    setPriority: () => priority = 3,
                    icon: Icon(Icons.looks_3_outlined),
                  ),
                ],
              ),
            ),
            Center(
              child: IconButton(
                iconSize: 40,
                icon: Icon(Icons.save),
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
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PriorityButton extends StatelessWidget {
  final Color? color;
  final Icon icon;

  Function() setPriority;
  PriorityButton({
    required this.icon,
    required this.color,
    required this.setPriority,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color,
      onPressed: setPriority,
      icon: icon,
      iconSize: 40,
    );
  }
}
