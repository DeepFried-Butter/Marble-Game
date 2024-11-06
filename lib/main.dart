import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'history_screen.dart';
import 'new_game_logic.dart';
import 'instructions_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MarbleGame(),
    );
  }
}

class MarbleGame extends StatefulWidget {
  @override
  _MarbleGameState createState() => _MarbleGameState();
}

class _MarbleGameState extends State<MarbleGame> {
  static const int boardSize = 4;
  List<List<String?>> board = List.generate(boardSize, (_) => List.generate(boardSize, (_) => null));
  String currentPlayer = '1';
  Color playerOneColor = Colors.blue;
  Color playerTwoColor = Colors.red;
  bool gameWon = false;
  bool gameDraw = false;
  Timer? timer;
  int timeLeft = 20;
  int playerOneWins = 0;
  int playerTwoWins = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timeLeft = 20;
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          placeRandomMarble();
        }
      });
    });
  }

  void placeRandomMarble() {
    List<int> availableCells = [];
    for (int row = 0; row < boardSize; row++) {
      for (int col = 0; col < boardSize; col++) {
        if (board[row][col] == null) {
          availableCells.add(row * boardSize + col);
        }
      }
    }

    if (availableCells.isNotEmpty) {
      int randomIndex = availableCells[Random().nextInt(availableCells.length)];
      int row = randomIndex ~/ boardSize;
      int col = randomIndex % boardSize;
      board[row][col] = currentPlayer;
      moveMarblesCounterclockwise();

      if (!checkWinCondition()) {
        if (checkDrawCondition()) {
          stopGame();
        } else {
          switchPlayer();
        }
      }
    }
  }

  void switchPlayer() {
    setState(() {
      currentPlayer = currentPlayer == '1' ? '2' : '1';
      startTimer();
    });
    if (checkWinCondition()) {
      stopGame();
    }
  }

  void placeMarble(int row, int col) {
    if (board[row][col] == null && !gameWon && !gameDraw) {
      setState(() {
        board[row][col] = currentPlayer;
        moveMarblesCounterclockwise();
        if (checkWinCondition()) {
        } else if (checkDrawCondition()) {
          stopGame();
        } else {
          switchPlayer();
        }
      });
    }
  }

  void moveMarblesCounterclockwise() {
    List<List<String?>> tempBoard = List.generate(boardSize, (_) => List.generate(boardSize, (_) => null));

    for (int row = 0; row < boardSize; row++) {
      for (int col = 0; col < boardSize; col++) {
        if (board[row][col] != null) {
          if (row == 0 && col > 0) {
            tempBoard[row][col - 1] = board[row][col];
          } else if (col == 0 && row < boardSize - 1) {
            tempBoard[row + 1][col] = board[row][col];
          } else if (row == boardSize - 1 && col < boardSize - 1) {
            tempBoard[row][col + 1] = board[row][col];
          } else if (col == boardSize - 1 && row > 0) {
            tempBoard[row - 1][col] = board[row][col];
          } else if (row == 1 && col == 1) {
            tempBoard[2][1] = board[1][1];
          } else if (row == 1 && col == 2) {
            tempBoard[1][1] = board[1][2];
          } else if (row == 2 && col == 1) {
            tempBoard[2][2] = board[2][1];
          } else if (row == 2 && col == 2) {
            tempBoard[1][2] = board[2][2];
          }
        }
      }
    }

    board = tempBoard;
  }

  bool checkWinCondition() {
    for (int i = 0; i < boardSize; i++) {
      if (checkLine([board[i][0], board[i][1], board[i][2], board[i][3]]) ||
          checkLine([board[0][i], board[1][i], board[2][i], board[3][i]])) {
        setState(() {
          gameWon = true;
          timer?.cancel();
          if (currentPlayer == '1') {
            playerOneWins++;
          } else {
            playerTwoWins++;
          }
        });
        return true;
      }
    }
    if (checkLine([board[0][0], board[1][1], board[2][2], board[3][3]]) ||
        checkLine([board[0][3], board[1][2], board[2][1], board[3][0]])) {
      setState(() {
        gameWon = true;
        timer?.cancel();
        if (currentPlayer == '1') {
          playerOneWins++;
        } else {
          playerTwoWins++;
        }
      });
      return true;
    }
    return false;
  }

  bool checkLine(List<String?> line) {
    return line.every((marble) => marble == currentPlayer);
  }

  bool checkDrawCondition() {
    for (int row = 0; row < boardSize; row++) {
      for (int col = 0; col < boardSize; col++) {
        if (board[row][col] == null) {
          return false;
        }
      }
    }
    return true;
  }

  void stopGame() {
    setState(() {
      gameDraw = true;
      timer?.cancel();
    });
  }

  void resetGame() {
    setState(() {
      board = List.generate(boardSize, (_) => List.generate(boardSize, (_) => null));
      currentPlayer = '1';
      gameWon = false;
      gameDraw = false;
      timer?.cancel();
    });
    startTimer();
  }

  void resetWins() {
    setState(() {
      playerOneWins = 0;
      playerTwoWins = 0;
    });
  }

  String getWinningPlayer() {
    return currentPlayer;
  }

  Color getWinningColor() {
    return currentPlayer == '1' ? playerOneColor : playerTwoColor;
  }

  void navigateToHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryScreen(playerOneWins: playerOneWins, playerTwoWins: playerTwoWins),
      ),
    );
  }

  void navigateToInstructions() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InstructionsScreen(),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marble Game'),
        actions: [
          TextButton(
            onPressed: () {
              NewGameLogic.resetWins(context, resetWins);
            },
            child: Text("New Game", style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: navigateToHistory,
            child: Text("History", style: TextStyle(color: Colors.black)),
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: resetGame,
          ),
          IconButton(
            icon: Icon(Icons.info, color: Colors.black),
            onPressed: navigateToInstructions,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!gameWon && !gameDraw)
                Text(
                  'Player $currentPlayer plays',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: currentPlayer == '1' ? playerOneColor : playerTwoColor,
                  ),
                ),
              if (!gameWon && !gameDraw)
                Text(
                  '$timeLeft',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
            ],
          ),
          SizedBox(height: 20),
          for (int row = 0; row < boardSize; row++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int col = 0; col < boardSize; col++)
                  GestureDetector(
                    onTap: () => placeMarble(row, col),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: board[row][col] != null ? Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: (board[row][col] == '1') ? playerOneColor : playerTwoColor,
                            shape: BoxShape.circle,
                          ),
                        ) : null,
                      ),
                    ),
                  ),
              ],
            ),
          SizedBox(height: 20),
          if (gameWon)
            Text(
              'Player ${getWinningPlayer()} Wins!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: getWinningColor()),
            ),
          if (gameDraw && !gameWon)
            Text(
              'Draw',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
        ],
      ),
    );
  }
}