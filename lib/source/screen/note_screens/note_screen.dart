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
          Navigator.pushNamed(context, AppRoutes.addNoteScreen);
        },
      ),
    );
  }

  ValueListenableBuilder<Box<NoteModel>> buildScaffoldBody() {
    return ValueListenableBuilder(
      valueListenable: Hive.box<NoteModel>(boxName).listenable(),
      builder: (BuildContext context, Box<NoteModel> noteBox, _) {
        if (noteBox.values.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Center(
                  child: Text(
                    "   NO NOTE\nCREATE ONE",
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

        return buildListView(noteBox);
      },
    );
  }

  ListView buildListView(Box<NoteModel> noteBox) {
    return ListView.builder(
      itemCount: noteBox.length,
      itemBuilder: (BuildContext context, int index) {
        //final todoModel = todoModelManager.readItem(index);
        final noteModel = noteBox.getAt(index);

        final color = Colors.black;

        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SelectedNoteScreen(
                index: index,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildInfoText(context, index, noteModel!, color),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  GestureDetector buildInfoText(
      BuildContext context, int index, NoteModel noteModel, Color? color) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SelectedNoteScreen(index: index),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(noteModel.title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(noteModel.description,
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.italic)),
          ),
        ],
      ),
    );
  }
}
