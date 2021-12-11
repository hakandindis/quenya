// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quenya/source/screen/note_screens/add_note_screen.dart';
import 'package:quenya/source/screen/note_screens/note_screen.dart';
import 'package:quenya/source/screen/opening_screen.dart';
import 'package:quenya/source/screen/todo_screens/add_todo_screen.dart';
import 'package:quenya/source/screen/todo_screens/todo_screen.dart';

class AppRoutes {
  static const String homeScreen = "/homeScreen";

  static const String noteScreen = "/noteScreen";
  static const String addNoteScreen = "/addNoteScreen";

  static const String todoScreen = "/todoScreen";
  static const String addTodoScreen = "/addTodoScreen";

  static const String openingScreen = "/openingScreen";

  static Map<String, WidgetBuilder> define() {
    return {
      noteScreen: (context) => NoteScreen(),
      addNoteScreen: (context) => AddNoteScreen(),
      todoScreen: (context) => TodoScreen(),
      addTodoScreen: (context) => AddTodoScreen(),
      openingScreen: (context) => OpeningScreen(),
    };
  }
}
