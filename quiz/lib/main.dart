import 'package:flutter/material.dart';

void main() {
  void onClick() {}

  runApp(
    MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.deepPurpleAccent],
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/images/quiz-logo.png', width: 400),
                Text(
                  'Learn Flutter the fun way',
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
                OutlinedButton(
                  onPressed: onClick,
                  child: Text(
                    'Start Quiz',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
