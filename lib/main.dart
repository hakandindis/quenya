import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quenya/source/database/note/note_model.dart';
import 'package:quenya/source/database/todo/todo_model.dart';
import 'package:quenya/source/navigation/routes.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<NoteModel>(NoteModelAdapter());
  Hive.registerAdapter<TodoModel>(TodoModelAdapter());

  await Hive.openBox<NoteModel>('notes');
  await Hive.openBox<TodoModel>('todos');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: AppRoutes.openingScreen,
      routes: AppRoutes.define(),
    );
  }
}
