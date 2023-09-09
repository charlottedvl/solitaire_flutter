import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    double padding = (MediaQuery.of(context).size.width) * 0.1;
    return Padding(
        padding: EdgeInsets.all(padding),
        child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                  "Profile Screen",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 2.0,
                  ),
                  textScaleFactor: 30.0
              ),
            ]
        )
    );
  }
}