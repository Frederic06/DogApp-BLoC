import 'package:flutter/material.dart';
import 'package:flutter_dogapp/services/repository.dart';
import 'package:flutter_dogapp/ui/breed_list.dart';

import 'login.dart';
class BottomBarWidget extends StatefulWidget {
  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    LoginWidget(repository: Repository()),
    BreedList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'DogApp',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
