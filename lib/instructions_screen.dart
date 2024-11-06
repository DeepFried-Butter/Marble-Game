import 'package:flutter/material.dart';

class InstructionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Instructions'),
      ),
      body: SingleChildScrollView( // Wrap the body in a scrollable view
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Buttons',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'New Game: Resets the game clearing the previous win history.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'History: Shows the total number of wins of the current game.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Text(
              'Game Mechanics',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              '1. Board Layout:\n• The game board is a 4x4 grid of cells.\n• The board is conceptually divided into two areas: an inner and an outer region.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              '2. Game Flow:\n• The game is played between two players, each with a set of marbles.\n• Players take turns placing their marbles on an empty cell of their choice within the grid.\n• On each turn, every marble on the board (both players\') moves one cell counterclockwise.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              '3. Objective:\n• The first player to align four of their marbles consecutively—either horizontally, vertically, or diagonally—wins the game.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Text(
              '4. Timer:\n• If a player does not make a move in 20 seconds, their turn is over and a marble will be placed randomly on the board.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}