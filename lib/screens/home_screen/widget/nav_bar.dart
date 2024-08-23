import 'package:flutter/material.dart';
import 'package:solitaire/shared/constants.dart';

class NavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;

  const NavBar(
      {Key? key, required this.selectedIndex, required this.onTabTapped})
      : super(key: key);

  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  int selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Profile',
      style: optionStyle,
    )
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onTabTapped(index); // Notify the parent about the tab change
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: lightGrey,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: green,
      unselectedItemColor: Colors.white70,
      onTap: onItemTapped,
    );
  }
}
