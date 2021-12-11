// ignore_for_file: prefer_const_constructors, unused_field

import 'package:flutter/material.dart';
import 'package:quenya/core/database/hivebox_manager.dart';
import 'package:quenya/source/database/note/note_model.dart';
import 'package:quenya/source/database/note/note_model_manager.dart';

class SelectedNoteScreen extends StatefulWidget {
  const SelectedNoteScreen({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  _SelectedNoteScreenState createState() => _SelectedNoteScreenState();
}

class _SelectedNoteScreenState extends State<SelectedNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  final String boxName = "notes";
  late IHiveBoxManager noteModelManager;

  late int priority;
  late final NoteModel noteModel;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    noteModelManager = NoteModelManager(boxName);

    noteModel = noteModelManager.readItem(widget.index);

    _titleController.text = noteModel.title;
    _descriptionController.text = noteModel.description;
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
      body: SingleChildScrollView(
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
                  hintText: "Something",
                  labelText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
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
                  noteModelManager.updateItem(
                    NoteModel(
                      title: _titleController.text,
                      description: _descriptionController.text,
                    ),
                    widget.index,
                  );
                  Navigator.of(context).pop();
                },
              ),
            ),
            Center(
              child: IconButton(
                iconSize: 40,
                icon: Icon(Icons.delete_outline_rounded),
                onPressed: () {
                  noteModelManager.deleteItem(widget.index);
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
