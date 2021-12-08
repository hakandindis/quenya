// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:quenya/core/database/hivebox_manager.dart';
import 'package:quenya/source/database/note/note_model.dart';
import 'package:quenya/source/database/note/note_model_manager.dart';
import 'package:quenya/source/navigation/routes.dart';

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
  //late final NoteModel _noteModel;
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    noteModelManager = NoteModelManager(boxName);
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
              noteModelManager.addItem(
                NoteModel(
                    title: _titleController.text,
                    description: _descriptionController.text),
              );

              Navigator.of(context).pushNamed(AppRoutes.noteScreen);
            },
          ),
        ],
      ),
    );
  }
}
