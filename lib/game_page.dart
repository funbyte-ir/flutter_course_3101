import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GamePageState();
  }
}

class GamePageState extends State<GamePage> {
  List<String> board = ["", "", "", "", "", "", "", "", ""];
  bool xTurn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("بازی دوز"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("تنظیمات بازی"),
                    content: Text(
                      "اینجا می‌توانید تنظیمات بازی را تغییر دهید.",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("بستن"),
                      ),
                    ],
                  );

                  // Dialog(
                  //   child: Padding(
                  //     padding: EdgeInsets.all(16),
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Text("تنظیمات بازی"),
                  //         SizedBox(height: 20),
                  //         ElevatedButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pop();
                  //           },
                  //           child: Text("بستن"),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // );
                },
              );
            },
            icon: Icon(Icons.settings),
          ),

          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("بازی ریست شد!")));
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),

      body: Center(
        child: SizedBox(
          width: 400,
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            children: [
              buildButton(0),
              buildButton(1),
              buildButton(2),
              buildButton(3),
              buildButton(4),
              buildButton(5),
              buildButton(6),
              buildButton(7),
              buildButton(8),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(int index) {
    return AspectRatio(
      aspectRatio: 1,
      child: ElevatedButton(
        onPressed: () {
          if (board[index] == "") {
            setState(() {
              if (xTurn) {
                board[index] = "X";
              } else {
                board[index] = "O";
              }
              xTurn = !xTurn;
              calculateWinner();
            });
          }
        },
        child: Center(
          child: Text(
            board[index],
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void calculateWinner() {
    // Check rows, columns, and diagonals for a winner
    List<List<int>> winningCombinations = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var combo in winningCombinations) {
      String first = board[combo[0]];
      if (first != "" && first == board[combo[1]] && first == board[combo[2]]) {
        // We have a winner
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Winner"),
            content: Text("$first wins!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Play Again"),
              ),
            ],
          ),
        );
        return;
      }
    }
  }
}
