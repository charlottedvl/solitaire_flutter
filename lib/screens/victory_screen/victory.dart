import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/backend/models/board.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';
import 'package:solitaire/screens/shared/screen_shape/title_button_screen.dart';
import 'package:solitaire/shared/string_constants.dart';
import 'package:solitaire/screens/shared/widget/button.dart';
import 'package:solitaire/screens/shared/widget/custom_title.dart';

class VictoryView extends StatefulWidget {
  const VictoryView({Key? key}) : super(key: key);

  @override
  VictoryViewState createState() => VictoryViewState();
}

class VictoryViewState extends State<VictoryView> {
  late ConfettiController confettiController;

  List<String> cards = [
    "you",
    "are",
    "the",
    "boss",
  ];

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

  void playAgain() {
    context.read<BoardProvider>().clearSavedGame();
    context.read<BoardProvider>().reinitializeCounterMoves();
    Navigator.pushNamed(
      context,
      '/board',
      arguments: Board(false, null, null, null, null, null, null, null),
    );
  }

  List<Widget> getWidgets() {
    return [
      CustomTitle(CONGRATS_EN, cards),
      Column(
        children: [
          CustomButton(onPressed: playAgain, title: "Play Again"),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
              onPressed: confettiController.play, title: "More confetti!"),
        ],
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = getWidgets();
    return Stack(
      children: [
        TitleButtonScreen(widgets: widgets),
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
