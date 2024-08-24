import 'package:flutter/material.dart';
import 'package:solitaire/shared/constants.dart';

class NavBar extends StatefulWidget {
  int? selectedIndex;

  NavBar({Key? key, this.selectedIndex}) : super(key: key);

  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  void onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });

    if (widget.selectedIndex != null) {
      switch (widget.selectedIndex) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/settings');
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int index;
    if (widget.selectedIndex != null) {
      index = widget.selectedIndex ?? 0;
    } else {
      index = 0;
    }
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: lightGreen,
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
      currentIndex: index,
      selectedItemColor: widget.selectedIndex == null ? Colors.white70 : green,
      unselectedItemColor: Colors.white70,
      onTap: onItemTapped,
    );
  }
}
