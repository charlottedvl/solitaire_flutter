import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solitaire/backend/providers/boardProvider.dart';

class InfoBar extends StatefulWidget implements PreferredSizeWidget {
  const InfoBar({super.key});

  @override
  State<InfoBar> createState() => InfoBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class InfoBarState extends State<InfoBar> {
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
              Text('Time:'), // You can format the time as needed
            ],
          );
        },
      ),
    );
  }
}
