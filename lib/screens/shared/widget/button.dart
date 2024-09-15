import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  void Function() onPressed;
  String title;
  double width;

  CustomButton(
      {super.key,
      required this.onPressed,
      required this.title,
      this.width = 0.6});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * width,
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
