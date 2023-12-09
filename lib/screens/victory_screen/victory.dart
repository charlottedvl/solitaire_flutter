import 'package:flutter/material.dart';
import 'package:solitaire/screens/board_screen/board_view.dart';

class VictoryView extends StatelessWidget {
  const VictoryView({super.key});

  Widget playAgainButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BoardView()));
      },
      child: const Text(
        "Play again",
        style: TextStyle(
          color: Colors.white,
        ),
        textScaleFactor: 1.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double padding = 0.1;
    return Container(
        height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
    image: DecorationImage(
    image: AssetImage("assets/images/media/background.jpg"),
    fit: BoxFit.cover,
    ),
    ),
    child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: <Widget>[
                  DefaultTextStyle(style: TextStyle(
                    fontSize: 30,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = Colors.purple,
                  ),
                      child: const Text(
                    "Congratulations !",
                    textAlign: TextAlign.center,
                  ),
                  ),
                  const DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                    child: Text(
                    "Congratulations !",
                    textAlign: TextAlign.center,
                  ),
                  )
                ],
              ),
              playAgainButton(context)
            ]))
    );
  }
}
