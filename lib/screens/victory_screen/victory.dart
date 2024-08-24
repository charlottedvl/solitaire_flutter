import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/backend/models/board.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:solitaire/screens/board_screen/board_screen.dart';

class VictoryView extends StatefulWidget {
  const VictoryView({Key? key}) : super(key: key);

  @override
  VictoryViewState createState() => VictoryViewState();
}

class VictoryViewState extends State<VictoryView> {
  late ConfettiController confettiController;

  @override
  void initState() {
    super.initState();
    confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    confettiController.play();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  Widget playAgainButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<BoardProvider>().clearSavedGame();
        Navigator.pushNamed(
          context,
          '/board',
          arguments: Board(true, null, null, null, null, null, null),
        );
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
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/media/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    DefaultTextStyle(
                      style: TextStyle(
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
                const SizedBox(height: 20),
                playAgainButton(context),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            numberOfParticles: 100,
            gravity: 0.65,
          ),
        ),
      ],
    );
  }
}
