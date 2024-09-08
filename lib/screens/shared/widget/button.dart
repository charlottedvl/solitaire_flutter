import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  void Function() onPressed;
  String title;

  CustomButton({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: ElevatedButton(
          onPressed: onPressed,
          style: Theme.of(context).elevatedButtonTheme.style,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ));
  }
}
