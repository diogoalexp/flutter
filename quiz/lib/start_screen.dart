import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void onClick() {}

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/quiz-logo.png', width: 300),
          SizedBox(height: 80),
          Text(
            'Learn Flutter the fun way!',
            style: const TextStyle(
              color: Color.fromARGB(255, 237, 223, 252),
              fontSize: 24,
            ),
          ),
          SizedBox(height: 20),
          OutlinedButton(
            onPressed: onClick,
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
            child: Text('Start Quiz'),
          ),
        ],
      ),
    );
  }
}
