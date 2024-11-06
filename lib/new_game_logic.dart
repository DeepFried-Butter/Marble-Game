import 'package:flutter/material.dart';

class NewGameLogic {
  static void resetWins(BuildContext context, Function resetWinCounts) {

    resetWinCounts();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Game has been reset!"),
        duration: Duration(seconds: 2),
      ),
    );
  }
}