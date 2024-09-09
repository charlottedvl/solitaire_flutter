import 'package:flutter/material.dart';
import 'package:solitaire/backend/models/board.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:solitaire/screens/board_screen/board_screen.dart';
import 'package:solitaire/screens/home_screen/home.dart';
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
                return MaterialPageRoute(builder: (context) => VictoryView());
              case '/victory':
                return MaterialPageRoute(builder: (context) => VictoryView());
              default:
                return MaterialPageRoute(
                  builder: (context) => Home(),
                );
            }
          },
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                titleTextStyle: TextStyle(
                    color: lightGreen,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Moderustic"),
              ),
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      foregroundColor: green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 0.0),
                      textStyle: const TextStyle(
                          fontFamily: "Moderustic",
                          fontSize: 12,
                          color: Colors.white))),
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                backgroundColor: green,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              )),
              textTheme: const TextTheme(
                titleLarge: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontFamily: 'Moderustic'),
                bodyLarge: TextStyle(
                  fontFamily: 'Moderustic',
                  fontSize: 20,
                  color: lightGreen,
                ),
                bodySmall: TextStyle(
                  fontFamily: 'Moderustic',
                  fontSize: 15,
                  color: lightGreen,
                ),
              )),
          home: Home(),
        ));
  }
}
