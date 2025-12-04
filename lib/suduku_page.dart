import 'package:flutter/material.dart';

class SudukuPage extends StatefulWidget {
  @override
  State<SudukuPage> createState() => _SudukuPageState();
}

class _SudukuPageState extends State<SudukuPage> {
  List<List<int>> board = List.generate(9, (_) => List.filled(9, 0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("بازی سودوکو")),
      body: SizedBox(
        width: 500,
        height: 500,
        child: GridView.count(
          crossAxisCount: 9,
          children: [
            for (int i = 0; i < 9; i++)
              for (int j = 0; j < 9; j++)
                Container(
                  margin: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: TextField(
                      controller: TextEditingController(
                        text: board[i][j] == 0 ? "" : board[i][j].toString(),
                      ),
                      onChanged: (value) {
                        int? number = int.tryParse(value);
                        setState(() {
                          if (number == null) {
                            board[i][j] = 0;
                          } else if (number < 1 || number > 9) {
                            board[i][j] = 0;
                          } else {
                            for (int x = 0; x < 9; x++) {
                              if (board[i][x] == number) {
                                board[i][j] = 0;
                                return;
                              }
                            }
                            board[i][j] = number;
                          }
                        });
                      },
                      textAlign: TextAlign.center,

                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: "",
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
