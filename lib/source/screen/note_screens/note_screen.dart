// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quenya/core/database/hivebox_manager.dart';
import 'package:quenya/source/database/note/note_model.dart';
import 'package:quenya/source/database/note/note_model_manager.dart';
import 'package:quenya/source/navigation/routes.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quenya/source/screen/note_screens/selected_note_screen.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final String boxName = "notes";
  late IHiveBoxManager noteModelManager;

  @override
  void initState() {
    noteModelManager = NoteModelManager(boxName);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Colors.black,
        //child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addNoteScreen);
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<NoteModel>(boxName).listenable(),
        builder: (BuildContext context, Box<NoteModel> noteBox, _) {
          if (noteBox.values.isEmpty) {
            return Center(
              child: Text("No Data"),
            );
          }

          return ListView.builder(
            itemCount: noteBox.length,
            itemBuilder: (BuildContext context, int index) {
              final noteModel = noteModelManager.readItem(index);
              return ListTile(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SelectedNoteScreen(index: index))),
                title: Text(noteModel!.title),
                subtitle: Text(noteModel.description),
                
              );
            },
          );
        },
      ),
    );
  }
}
