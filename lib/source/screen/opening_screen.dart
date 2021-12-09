// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
//import 'package:quenya/source/screen/home_screen.dart';
import 'package:quenya/source/screen/note_screens/note_screen.dart';
import 'package:quenya/source/screen/todo_screens/todo_screen.dart';

class OpeningScreen extends StatefulWidget {
  const OpeningScreen({Key? key}) : super(key: key);

  @override
  _OpeningScreenState createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    NoteScreen(),
    //HomeScreen(),
    TodoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      backgroundColor: Colors.deepPurple[300],
      //appBar: AppBar(title: Text("Notes")),
      body: _pages[_selectedIndex],
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      iconSize: 40,
      elevation: 0,
      //backgroundColor: Colors.deepPurple[300],
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _navigateBottomBar,
      //backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.note_alt_outlined), label: ""),
        //BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.today_outlined), label: ""),
      ],
    );
  }

  _navigateBottomBar(int index) {
    _selectedIndex = index;
    setState(() {});
    //print(_selectedIndex);
  }
}
