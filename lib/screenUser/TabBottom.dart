import 'package:flutter/material.dart';
import 'package:kpointapplication/screenUser/HomePage.dart';
import 'package:kpointapplication/screenUser/LogoPage.dart';
import 'package:kpointapplication/screenUser/registerPage.dart';

class TabBottom extends StatefulWidget {
  const TabBottom({super.key});

  @override
  State<TabBottom> createState() => _TabBottomState();
}

class _TabBottomState extends State<TabBottom> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[

    HomePage(),
    LogoPage(),
    registerPage()
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'My Card',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
