// ignore_for_file: prefer_const_constructors, unused_field

import 'package:flutter/material.dart';
import 'package:quenya/core/database/hivebox_manager.dart';
import 'package:quenya/source/database/note/note_model.dart';
import 'package:quenya/source/database/note/note_model_manager.dart';
import 'package:quenya/source/navigation/routes.dart';

class SelectedNoteScreen extends StatefulWidget {
  const SelectedNoteScreen({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  _SelectedNoteScreenState createState() => _SelectedNoteScreenState();
}

class _SelectedNoteScreenState extends State<SelectedNoteScreen> {
  _SelectedNoteScreenState() : super();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  final String boxName = "notes";
  late IHiveBoxManager noteModelManager;
  late final NoteModel _noteModel;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    noteModelManager = NoteModelManager(boxName);

    _noteModel = noteModelManager.readItem(widget.index);

    _titleController.text = _noteModel.title;
    _descriptionController.text = _noteModel.description;
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
            icon: Icon(Icons.upgrade),
            onPressed: () {
              noteModelManager.updateItem(
                NoteModel(
                    title: _titleController.text,
                    description: _descriptionController.text),
                widget.index,
              );
              Navigator.of(context).pushNamed(AppRoutes.noteScreen);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              noteModelManager.deleteItem(widget.index);
              Navigator.of(context).pushNamed(AppRoutes.noteScreen);
            },
          ),
        ],
      ),
    );
  }
}
