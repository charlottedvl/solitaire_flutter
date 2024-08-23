import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solitaire/screens/home_screen/home.dart';
import 'package:solitaire/screens/home_screen/widget/nav_bar.dart';
import 'package:solitaire/screens/profile_screen/profile.dart';
import 'package:solitaire/screens/settings_screen/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // Initialize the selected index
  int selectedIndex = 0;

  final List<Widget> children = [
    Home(),
    const Profile(),
    const Settings(),
  ];

  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();

    bool success = await prefs.clear();

    if (success) {
      print('All data in SharedPreferences has been cleared.');
    } else {
      print('Failed to clear SharedPreferences.');
    }
  }

  @override
  Widget build(BuildContext context) {
    clearAllData();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/media/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: children[selectedIndex],
        ),
        bottomNavigationBar: NavBar(
          selectedIndex: selectedIndex,
          onTabTapped: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
