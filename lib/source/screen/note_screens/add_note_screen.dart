// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:quenya/core/database/hivebox_manager.dart';
import 'package:quenya/source/database/note/note_model.dart';
import 'package:quenya/source/database/note/note_model_manager.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  final String boxName = "notes";
  late IHiveBoxManager noteModelManager;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();

    noteModelManager = NoteModelManager(boxName);
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
      //appBar: AppBar(),
      body: SingleChildScrollView(
        controller: ScrollController(initialScrollOffset: 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back_ios_new),
              ),
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
            Center(
              child: IconButton(
                iconSize: 40,
                icon: Icon(Icons.save),
                onPressed: () {
                  noteModelManager.addItem(
                    NoteModel(
                      title: _titleController.text,
                      description: _descriptionController.text,
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
