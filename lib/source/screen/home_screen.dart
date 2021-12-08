// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:quenya/source/navigation/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: buildBottomNavigationBar(),
      backgroundColor: Colors.deepPurple[300],
      appBar: AppBar(title: Text("Notes")),
      
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottomIcon(
                  icon: Icon(Icons.notes_outlined),
                  routeName: AppRoutes.noteScreen,
                ),
                BottomIcon(
                  icon: Icon(Icons.home),
                  routeName: AppRoutes.homeScreen,
                ),
                BottomIcon(
                  icon: Icon(Icons.today_rounded),
                  routeName: AppRoutes.todoScreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row buildBottomBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                offset: Offset(4.0, 4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4.0, -4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.note_alt_outlined,
            ),
            iconSize: 50,
          ),
        ),
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                offset: Offset(4.0, 4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4.0, -4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.note_alt_outlined,
            ),
            iconSize: 50,
          ),
        ),
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                offset: Offset(4.0, 4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
              BoxShadow(
                color: Colors.white,
                offset: Offset(-4.0, -4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.note_alt_outlined,
            ),
            iconSize: 50,
          ),
        ),
      ],
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      iconSize: 40,
      elevation: 0,
      backgroundColor: Colors.deepPurple[300],
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _navigateBottomBar,
      //backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.note_alt_outlined), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "")
      ],
    );
  }

  _navigateBottomBar(int index) {
    _selectedIndex = index;
    setState(() {});
    print(_selectedIndex);
  }
}

class BottomIcon extends StatelessWidget {
  final Icon icon;
  final String routeName;
  BottomIcon({required this.icon, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pushNamed(routeName),
      icon: icon,
      iconSize: MediaQuery.of(context).size.width * 0.15,
    );
  }
}
