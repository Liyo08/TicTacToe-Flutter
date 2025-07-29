import 'package:flutter/material.dart';

void main() => runApp(TicTacToe());

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> board = List.filled(9, '');
  bool xTurn = true;

  void handleTap(int index) {
    if (board[index] == '') {
      setState(() {
        board[index] = xTurn ? 'X' : 'O';
        xTurn = !xTurn;
      });
      checkWinner();
    }
  }

  void checkWinner() {
    List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],  // rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8],  // columns
      [0, 4, 8], [2, 4, 6]              // diagonals
    ];

    for (var pattern in winPatterns) {
      String first = board[pattern[0]];
      if (first != '' && first == board[pattern[1]] && first == board[pattern[2]]) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Winner!'),
            content: Text('$first wins'),
            actions: [
              TextButton(
                child: Text('Restart'),
                onPressed: () {
                  setState(() {
                    board = List.filled(9, '');
                    xTurn = true;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tic Tac Toe')),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: board.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => handleTap(index),
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                board[index],
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}