import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final int playerOneWins;
  final int playerTwoWins;

  HistoryScreen({required this.playerOneWins, required this.playerTwoWins});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Win History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Player 1 Wins: $playerOneWins',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Player 2 Wins: $playerTwoWins',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}