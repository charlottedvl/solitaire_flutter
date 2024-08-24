import 'package:flutter/material.dart';
import 'package:solitaire/backend/models/board.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:solitaire/screens/board_screen/board_screen.dart';
import 'package:solitaire/screens/home_screen/home.dart';
import 'package:solitaire/screens/home_screen/widget/nav_bar.dart';
import 'package:solitaire/screens/profile_screen/profile.dart';
import 'package:solitaire/screens/settings_screen/settings.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/screens/victory_screen/victory.dart';
import 'package:solitaire/shared/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => BoardProvider()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          initialRoute: '/home',
          onGenerateRoute: (settings) {
            if (settings.name == '/board') {
              final board = settings.arguments as Board;
              return MaterialPageRoute(
                builder: (context) => BoardScreen(board: board),
              );
            }
            switch (settings.name) {
              case '/home':
                return MaterialPageRoute(builder: (context) => Home());
              case '/settings':
                return MaterialPageRoute(builder: (context) => Settings());
              case '/victory':
                return MaterialPageRoute(builder: (context) => VictoryView());
              default:
                return MaterialPageRoute(
                  builder: (context) => Home(),
                );
            }
          },
          theme: ThemeData(
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    foregroundColor: green,
                    textStyle: const TextStyle(
                      fontFamily: "Moderustic",
                      fontSize: 12,
                    ))),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: green,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    textStyle: const TextStyle(
                      fontFamily: 'Moderustic',
                      fontSize: 15,
                      color: lightGreen,
                    ))),
            textTheme: const TextTheme(
              titleLarge: TextStyle(
                  fontSize: 35, color: Colors.white, fontFamily: 'Moderustic'),
            ),
          ),
          home: Home(),
        ));
  }
}
