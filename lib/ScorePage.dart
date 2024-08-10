import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final VoidCallback restartQuiz; // Add this line

  ScorePage({
    required this.score,
    required this.totalQuestions,
    required this.restartQuiz, // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Score'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz Completed!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Score: $score/$totalQuestions',
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: restartQuiz, // Call the restartQuiz method
              child: Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

