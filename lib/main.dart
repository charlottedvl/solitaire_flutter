import 'package:flutter/material.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:solitaire/screens/home_screen/home.dart';
import 'package:solitaire/screens/home_screen/widget/nav_bar.dart';
import 'package:solitaire/screens/profile_screen/profile.dart';
import 'package:solitaire/screens/settings_screen/settings.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => BoardProvider()),
        ],
        child: MaterialApp(
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
        ));
  }
}
