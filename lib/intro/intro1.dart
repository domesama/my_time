import 'package:flutter/material.dart';

class Intro1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Center(
          child: Text
          ("Begin your journal")
            ),
          Text("Nahee")
        ],
        ),
      ),
    );
  }
}