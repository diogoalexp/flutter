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
          // Opacity(
          //   opacity: 0.6,
          //   child: Image.asset('assets/images/quiz-logo.png', width: 300),
          // ),
          // not well perfomant as below
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color: const Color.fromARGB(
              150, //hack to transparance with better perfomance
              255,
              255,
              255,
            ),
          ),
          SizedBox(height: 80),
          Text(
            'Learn Flutter the fun way!',
            style: const TextStyle(
              color: Color.fromARGB(255, 237, 223, 252),
              fontSize: 24,
            ),
          ),
          SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: onClick,
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Start Quiz'),
          ),
        ],
      ),
    );
  }
}
