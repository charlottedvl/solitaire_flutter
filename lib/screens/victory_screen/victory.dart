import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/backend/models/board.dart';
import 'package:solitaire/backend/providers/board_provider.dart';
import 'package:solitaire/screens/shared/screen_shape/title_button_screen.dart';
import 'package:solitaire/shared/string_constants.dart';
import 'package:solitaire/screens/shared/widget/button.dart';
import 'package:solitaire/screens/shared/widget/custom_title.dart';
import 'package:solitaire/shared/utils.dart';

class VictoryView extends StatefulWidget {
  const VictoryView({Key? key}) : super(key: key);

  @override
  VictoryViewState createState() => VictoryViewState();
}

class VictoryViewState extends State<VictoryView> {
  late ConfettiController confettiController;
  CustomUtils utils = CustomUtils();

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
    context.read<BoardProvider>().reinitializeInfos();
    Navigator.pushNamed(
      context,
      '/board',
      arguments: Board(false, null, null, null, null, null, null, null),
    );
  }

  List<Widget> getWidgets() {
    return [
      Column(
        children: [
          CustomTitle(CONGRATS_EN, cards),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.01,
          ),
          Consumer<BoardProvider>(
            builder: (context, boardProvider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Moves: ${boardProvider.counterMoves}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                      'Time: ${utils.formatTime(boardProvider.elapsedSeconds)}',
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              );
            },
          ),
        ],
      ),
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
