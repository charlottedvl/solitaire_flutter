import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToolBarButton extends StatelessWidget {
  Function action;
  String label;
  Icon icon;

  ToolBarButton(
      {super.key,
      required this.action,
      required this.label,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: Theme.of(context).textButtonTheme.style,
      onPressed: () {
        action();
      },
      child: SizedBox(
        // Need to adjust the width
        width: MediaQuery.of(context).size.width * 0.15,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(height: 4),
            Text(
              label,
            ),
          ],
        ),
      ),
    );
  }
}
