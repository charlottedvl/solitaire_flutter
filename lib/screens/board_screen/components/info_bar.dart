import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solitaire/backend/models/board.dart';
import 'package:solitaire/backend/providers/board_provider.dart';

class InfoBar extends StatefulWidget implements PreferredSizeWidget {
  const InfoBar({super.key});

  @override
  State<InfoBar> createState() => InfoBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class InfoBarState extends State<InfoBar> with WidgetsBindingObserver {
  BoardProvider? boardProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    boardProvider = context.read<BoardProvider>();
    boardProvider!.startTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    boardProvider?.stopTimer();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      boardProvider?.stopTimer();
    } else if (state == AppLifecycleState.resumed) {
      boardProvider?.startTimer();
    }
  }

  String formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Consumer<BoardProvider>(
        builder: (context, boardProvider, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Moves: ${boardProvider.counterMoves}'),
              Text('Time: ${formatTime(boardProvider.elapsedSeconds)}'),
            ],
          );
        },
      ),
    );
  }
}
